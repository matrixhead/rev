import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';

class RevData {
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

  Future<Channel> openDirectMessage(RevHttpClient httpClient,
      {required String id}) {
    try {
      return api.openDirectMessage(httpClient, id: id);
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

  Future<(List<Message>,List<RelationUser>)> fetchMessages(
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

  Future<Message> sendMessage({required RevHttpClient httpClient, required String channelId, required String content,required String idempotencykey}) {
    try {
      return api.sendMessage(httpClient: httpClient, channelId:channelId,content:content,idempotencyKey:idempotencykey);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }
}
