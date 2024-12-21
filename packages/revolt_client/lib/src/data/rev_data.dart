import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/data/channel_repo.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:revolt_client/src/state/rev_state.dart';

class RevData {
  RevData(this.state, this.httpClient)
    : channelRepo = ChannelReposotory(state: state);
  final RevState state;
  final RevHttpClient httpClient;
  final ChannelReposotory channelRepo;

  Future<CurrentUser> fetchSelf() async {
    if (state.userRepoState.currentUser case final CurrentUser cu) {
      return cu;
    }
    try {
      return api.fetchSelf(httpClient);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> fetchUser({required String id}) {
    try {
      return api.fetchUser(httpClient, id: id);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> sendFriendRequest({required String username}) {
    try {
      return api.sendFriendRequest(httpClient, username: username);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> acceptFriendRequest({required String id}) async {
    try {
      final user = await api.acceptFriendRequest(httpClient, id: id);
      state.userRepoState.addorUpdateRelationUsers(user);
      return user;
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RevChannel> getDmChannelForUser({required String userid}) async {
    if (channelRepo.getDmChannelForUser(userid) case final RevChannel channel) {
      return channel;
    }
    return openDirectMessageChannel(id: userid);
  }

  Future<RevChannel> openDirectMessageChannel({required String id}) async {
    try {
      final channel = await api.openDirectMessageChannel(httpClient, id: id);
      return channelRepo.addOrUpdateChannel(channel, await fetchSelf());
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RevChannel> fetchChannel({required String channelId}) async {
    if (channelRepo.getChannelforId(channelId) case final RevChannel channel) {
      return channel;
    }
    try {
      final channel = await api.fetchChannel(httpClient, channelId: channelId);
      return channelRepo.addOrUpdateChannel(channel, await fetchSelf());
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<List<Channel>> fetchDirectMessageChannels(RevHttpClient httpClient) {
    try {
      return api.fetchDirectMessageChannels(httpClient);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<void> fetchMessages({
    required String id,
    int? limit,
    String? before,
    String? after,
    String? sort,
    String? nearby,
    bool? includeUsers,
  }) async {
    try {
      final (messages, _) = await api.fetchMessages(
        httpClient: httpClient,
        id: id,
        after: after,
        before: before,
        includeUsers: includeUsers,
        limit: limit,
        nearby: nearby,
        sort: sort,
      );
      channelRepo.getChannelforId(id)?.addMessages(messages);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<Message> sendMessage({
    required String channelId,
    required String content,
    required String idempotencyKey,
  }) async {
    try {
      final channel = channelRepo.getChannelforId(channelId)!
      ..addSendMessage(
        ClientRevMessage(content: content, idempotencyKey: idempotencyKey),
      );
      final message = await api.sendMessage(
        httpClient: httpClient,
        channelId: channelId,
        content: content,
        idempotencyKey: idempotencyKey,
      );
      channel.addMessages([message]);
      return message;
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<void> onReadyEvent(ReadyEvent readyEvent) async {
    final currentRU = state.userRepoState.relationUsers.value;
    for (final user in readyEvent.users) {
      switch (user) {
        case final RelationUser relationUser:
          currentRU[relationUser.id] = relationUser;
        case final CurrentUser currentUser:
          state.userRepoState.currentUser = currentUser;
      }
    }
    state.userRepoState.relationUsers.add(currentRU);
    for (final channel in readyEvent.channels) {
      channelRepo.addOrUpdateChannel(channel, await fetchSelf());
    }
  }

  Future<void> onMessageEvent(MessageEvent messageEvent) async {
    final channel = await fetchChannel(channelId: messageEvent.message.channel);
    channel.addMessages([messageEvent.message]);
  }

  void onUserRelationShipEvent(UserRelationShipEvent userRelationShipEvent) {
    state.userRepoState.addorUpdateRelationUsers(userRelationShipEvent.user);
  }
}
