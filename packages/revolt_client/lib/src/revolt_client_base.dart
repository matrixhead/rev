import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:revolt_client/src/auth/auth.dart';
import 'package:revolt_client/src/config/config.dart';
import 'package:revolt_client/src/data/data.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:revolt_client/src/state/channel_repository.dart';
import 'package:revolt_client/src/state/rev_state.dart';
import 'package:revolt_client/src/ws_channel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'models/models.dart';

class RevoltClient {
  final RevHttpClient httpClient;
  final RevAuth revAuth;
  late final RevData revData;
  final RevState revState;
  final WsChannel wsChannel;
  late final SharedPreferencesAsync prefs;

  RevoltClient({
    Client? httpClient,
    WebSocketChannel? wsChannel,
    RevConfig? clientConfig,
  })  : httpClient = RevHttpClient(
          httpClient: httpClient,
          config: clientConfig ?? RevConfig.debug(),
        ),
        revState = RevState(),
        wsChannel = WsChannel(
          config: clientConfig ?? RevConfig.debug(),
          channel: wsChannel,
        ),
        revAuth = RevAuth() {
    revData = RevData(revState);
    _init();
  }

  _init() async {
    prefs = SharedPreferencesAsync();
    setUpAuth();
    listenOnWsEvent();
  }

  listenOnWsEvent() {
    wsChannel.stream.listen((event) {
      switch (event) {
        case ReadyEvent readyEvent:
          revData.onReadyEvent(readyEvent);
          break;
        default:
      }
    });
  }

  setUpAuth() async {
    revAuth.authEvents.listen((authEvent) {
      if (authEvent == AuthStatus.authsucess) {
        httpClient.setToken = revAuth.session!.sessionToken;
        wsChannel.authenticateWsChannel(revAuth.session!.sessionToken);
      } else {
        httpClient.setToken = null;
      }
    });

    if (await prefs.getString("session") case String json) {
      revAuth.setSession = SessionDetails.fromJson(jsonDecode(json));
    }
  }

  login(
      {required String email,
      String? password,
      String? challenge,
      String? friendlyName,
      String? captcha}) async {
    await revAuth.login(httpClient,
        email: email,
        password: password,
        challenge: challenge,
        friendlyName: friendlyName,
        captcha: captcha);
    prefs.setString("session", jsonEncode(revAuth.session!.toJson()));
  }

  verifyAccount({required String verificationCode}) async =>
      revAuth.verifyAccount(httpClient, verificationCode);

  signUp(
          {required String email,
          required String password,
          String? invite,
          String? captcha}) async =>
      revAuth.signUp(
        httpClient,
        email: email,
        password: password,
        captcha: captcha,
        invite: invite,
      );

  Future<CurrentUser> fetchSelf() async => revData.fetchSelf(httpClient);

  Future<CurrentUser> completeOnboarding({required String username}) async =>
      revData.completeOnboarding(httpClient, username);

  Future<RelationUser> fetchUser({required String id}) async =>
      revData.fetchUser(httpClient, id: id);

  Future<RelationUser> sendFriendRequest(
          {required String username }) async =>
      revData.sendFriendRequest(httpClient,
          username: username);

  Future<RelationUser> acceptFriendRequest({required String id}) async =>
      revData.acceptFriendRequest(httpClient, id: id);

  Future<EnrichedChannel> getDmChannelForUser({required String userId}) async =>
      revData.getDmChannelForUser(httpClient, userid: userId);

  Future<List<Channel>> fetchDirectMessageChannels() async =>
      revData.fetchDirectMessageChannels(httpClient);

  Future<(List<Message>, List<RelationUser>)> fetchMessages({
    required String id,
    int? limit,
    String? before,
    String? after,
    String? sort,
    String? nearby,
    bool? includeUsers,
  }) async =>
      revData.fetchMessages(
        httpClient: httpClient,
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
    return revData.sendMessage(
        httpClient: httpClient,
        channelId: channelId,
        content: content,
        idempotencykey: idempotencykey ?? getRandString(20));
  }

  BehaviorSubject<AuthStatus> get authEvents => revAuth.authEvents;
  
  BehaviorSubject<Map<String,RelationUser>> get relationUsersStream => revState.relationUsers;
}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
