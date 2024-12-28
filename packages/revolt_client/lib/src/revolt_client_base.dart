import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:revolt_client/src/api_wrapper/helpers.dart';
import 'package:revolt_client/src/auth/auth.dart';
import 'package:revolt_client/src/config/config.dart';
import 'package:revolt_client/src/data/channel_repo.dart';
import 'package:revolt_client/src/data/rev_data.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/models.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:revolt_client/src/state/rev_state.dart';
import 'package:revolt_client/src/ws_channel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RevoltClient {
  factory RevoltClient({
    Client? httpClient,
    WebSocketChannel? wsChannel,
    RevConfig? clientConfig,
    SharedPreferencesAsync? sharedPreferences,
  }) {
    final revState = RevState();
    final revConfig = clientConfig ?? RevConfig.debug();
    final revHttpClient = RevHttpClient(
      httpClient: httpClient,
      config: revConfig,
      state: revState,
    );
    final revWsChannel = RevWsChannel(channel: wsChannel, config: revConfig);
    final prefs = sharedPreferences ?? SharedPreferencesAsync();
    final revAuth = RevAuth(state: revState, revHttpClient: revHttpClient);
    return RevoltClient._internal(
      httpClient: revHttpClient,
      wsChannel: revWsChannel,
      prefs: prefs,
      revState: revState,
      revAuth: revAuth,
    );
  }

  RevoltClient._internal({
    required RevHttpClient httpClient,
    required RevWsChannel wsChannel,
    required SharedPreferencesAsync prefs,
    required RevState revState,
    required RevAuth revAuth,
  }) : _sharedpreferences = prefs,
       _wsChannel = wsChannel,
       _httpClient = httpClient,
       _revState = revState,
       _revAuth = revAuth;

  RevHttpClient _httpClient;
  final RevWsChannel _wsChannel;
  final SharedPreferencesAsync _sharedpreferences;
  late final RevAuth _revAuth;
  final RevState _revState;
  RevData? _revData;

  RevData get _getRevData {
    if (_revData case final RevData revdata) {
      return revdata;
    } else {
      throw RevDataUnauthorizedAccess();
    }
  }

  Future<void> init() async {
    // await _sharedpreferences.clear();
    await setUpWs();
    await setUpAuth();
  }

  Future<void> setUpWs() async {
    _wsChannel.init();
    await _wsChannel.isReady;
    _wsChannel.stream.listen((event) {
      switch (event) {
        case final ReadyEvent readyEvent:
          _getRevData.onReadyEvent(readyEvent);
        case final MessageEvent messageEvent:
          _getRevData.onMessageEvent(messageEvent);
        case final UserRelationShipEvent userRelationShipEvent:
          _getRevData.onUserRelationShipEvent(userRelationShipEvent);
        case final ChannelCreateEvent channelCreateEvent:
          _getRevData.onChannelCreateEvent(channelCreateEvent);
        default:
      }
    });
  }

  Future<void> setUpAuth() async {
    _revState.authRepoState.authEvents.listen((authEvent) {
      if (authEvent == AuthStatus.authsucess) {
        _wsChannel.authenticateWsChannel(
          _revState.authRepoState.session!.sessionToken,
        );
        _revData = RevData(_revState, _httpClient);
      }
    });

    if (await _sharedpreferences.getString('session') case final String json) {
      _revAuth.setSession(SessionDetails.fromJson(parseJsonToMap(json)));
    }
  }

  Future<void> login({
    required String email,
    String? password,
    String? challenge,
    String? friendlyName,
    String? captcha,
  }) async {
    await _revAuth.loginAndCheckOnboarding(
      email: email,
      password: password,
      challenge: challenge,
      friendlyName: friendlyName,
      captcha: captcha,
    );
    await _sharedpreferences.setString(
      'session',
      jsonEncode(_revState.authRepoState.session!.toJson()),
    );
  }

  Future<void> verifyAccount({required String verificationCode}) async =>
      _revAuth.verifyAccount(verificationCode);

  Future<void> signUp({
    required String email,
    required String password,
    String? invite,
    String? captcha,
  }) async => _revAuth.signUp(
    email: email,
    password: password,
    captcha: captcha,
    invite: invite,
  );

  Future<CurrentUser> fetchSelf() async => _getRevData.fetchSelf();

  Future<CurrentUser> completeOnboarding({required String username}) async =>
      _revAuth.completeOnboarding(username);

  Future<RelationUser> fetchUser({required String id}) async =>
      _getRevData.fetchUser(id: id);

  Future<RelationUser> sendFriendRequest({required String username}) async =>
      _getRevData.sendFriendRequest(username: username);

  Future<RelationUser> acceptFriendRequest({required String id}) async =>
      _getRevData.acceptFriendRequest(id: id);

  Future<RevChannel> getDmChannelForUser({required String userId}) async =>
      _getRevData.getDmChannelForUser(userid: userId);

  Future<RevChannel> getChannelforId({required String channelId}) async =>
      _getRevData.fetchChannel(channelId: channelId);

  Future<List<Channel>> fetchDirectMessageChannels() async =>
      _getRevData.fetchDirectMessageChannels(_httpClient);

  Future<void> fetchMessages({
    required String id,
    int? limit,
    String? before,
    String? after,
    String? sort,
    String? nearby,
    bool? includeUsers,
  }) async => _getRevData.fetchMessages(
    id: id,
    after: after,
    before: before,
    includeUsers: includeUsers,
    limit: limit,
    nearby: nearby,
    sort: sort,
  );

  Future<Message> sendMessage({
    required String channelId,
    required String content,
    String? idempotencykey,
  }) async {
    return _getRevData.sendMessage(
      channelId: channelId,
      content: content,
      idempotencyKey: idempotencykey ?? getuuid(),
    );
  }

  Stream<Map<String, RelationUser>> getOtherUsersForChannel(
    RevChannel channel,
  ) {
    return _getRevData.getOtherUsersForChannelStream(channel);
  }

  BehaviorSubject<AuthStatus> get authEvents =>
      _revState.authRepoState.authEvents;

  BehaviorSubject<Map<String, RelationUser>> get relationUsersStream =>
      _revState.userRepoState.relationUsers;
}

String getuuid() {
  return const Uuid().v1();
}
