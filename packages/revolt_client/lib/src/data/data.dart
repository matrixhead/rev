import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:revolt_client/src/state/channel_repository.dart';
import 'package:revolt_client/src/state/rev_state.dart';

class RevData {
  final RevState revState;
  RevData(this.revState);

  Future<CurrentUser> fetchSelf(
    RevHttpClient httpClient,
  ) async {
    try {
      return api.fetchSelf(httpClient);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<CurrentUser> completeOnboarding(
      RevHttpClient httpClient, String username) {
    try {
      return api.completeOnboarding(httpClient, username);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> fetchUser(RevHttpClient httpClient,
      {required String id}) {
    try {
      return api.fetchUser(httpClient, id: id);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> sendFriendRequest(RevHttpClient httpClient,
      {required String username}) {
    try {
      return api.sendFriendRequest(httpClient, username: username);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> acceptFriendRequest(RevHttpClient httpClient,
      {required String id}) {
    try {
      return api.acceptFriendRequest(httpClient, id: id);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RevChannel> getDmChannelForUser(RevHttpClient httpClient,
      {required String userid}) async {
    if (revState.channelRepo.getDmChannelForUser(userid)
        case RevChannel channel) {
      return channel;
    }
    return openDirectMessageChannel(httpClient, id: userid);
  }

  Future<RevChannel> openDirectMessageChannel(RevHttpClient httpClient,
      {required String id}) async {
    try {
      final channel = await api.openDirectMessageChannel(httpClient, id: id);
      return revState.channelRepo
          .addOrUpdateChannel(channel, revState.currentUser!);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RevChannel> fetchChannel(RevHttpClient httpClient,
      {required String channelId}) async {
    if (revState.channelRepo.getChannelforId(channelId)
        case RevChannel channel) {
      return channel;
    }
    try {
      final channel = await api.fetchChannel(httpClient, channelId: channelId);
      return revState.channelRepo
          .addOrUpdateChannel(channel, revState.currentUser!);
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

  Future<(List<Message>, List<RelationUser>)> fetchMessages(
      {required RevHttpClient httpClient,
      required String id,
      int? limit,
      String? before,
      String? after,
      String? sort,
      String? nearby,
      bool? includeUsers}) async {
    try {
      return api.fetchMessages(
        httpClient: httpClient,
        id: id,
        after: after,
        before: before,
        includeUsers: includeUsers,
        limit: limit,
        nearby: nearby,
        sort: sort,
      );
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<Message> sendMessage(
      {required RevHttpClient httpClient,
      required String channelId,
      required String content,
      required String idempotencykey}) {
    try {
      return api.sendMessage(
          httpClient: httpClient,
          channelId: channelId,
          content: content,
          idempotencyKey: idempotencykey);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  void onReadyEvent(ReadyEvent readyEvent) {
    final currentRU = revState.relationUsers.value;
    for (final user in readyEvent.users) {
      switch (user) {
        case RelationUser relationUser:
          currentRU[relationUser.id] = relationUser;
          break;
        case CurrentUser currentUser:
          revState.currentUser = currentUser;
      }
    }
    revState.relationUsers.add(currentRU);
    for (final channel in readyEvent.channels) {
      revState.channelRepo.addOrUpdateChannel(channel, revState.currentUser!);
    }
  }
}
