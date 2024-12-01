import 'dart:convert';

import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/http_client.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';

Future<CurrentUser> fetchSelf(
  RevHttpClient clientConfig,
) async {
  try {
    final response = await clientConfig.get(path: "/users/@me");
    return CurrentUser.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<CurrentUser> completeOnboarding(
    RevHttpClient clientConfig, String username) async {
  final body = json.encode({
    "username": username,
  });
  try {
    final response =
        await clientConfig.post(path: "/onboard/complete", body: body);
    return CurrentUser.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<RelationUser> fetchUser(RevHttpClient httpClient,
    {required String id}) async {
  try {
    final response = await httpClient.get(path: "/users/$id");
    return RelationUser.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<RelationUser> sendFriendRequest(RevHttpClient httpClient,
    {required String username}) async {
  final body = json.encode({
    "username": username,
  });
  try {
    final response = await httpClient.post(path: "/users/friend", body: body);
    return RelationUser.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<RelationUser> acceptFriendRequest(
  RevHttpClient httpClient, {
  required String id,
}) async {
  try {
    final response = await httpClient.put(
      path: "/users/$id/friend",
    );
    return RelationUser.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<Channel> openDirectMessage(RevHttpClient httpClient,
    {required String id}) async {
  try {
    final response = await httpClient.get(path: "/users/$id/dm");
    return Channel.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<List<Channel>> fetchDirectMessageChannels(
  RevHttpClient httpClient,
) async {
  try {
    final response = await httpClient.get(path: "/users/dms");
    return List<Channel>.from(jsonDecode(response.body).map((v) {
      return Channel.fromJson(v);
    }));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

//todo: move this to a seperate module of channels
Future<(List<Message>, List<RelationUser>)> fetchMessages(
    {required RevHttpClient httpClient,
    required String id,
    int? limit,
    String? before,
    String? after,
    String? sort,
    String? nearby,
    bool? includeUsers}) async {
  final queries = {
    "limit": limit,
    "after": after,
    "sort": sort,
    "nearby": nearby,
    "include_users": includeUsers?.toString()
  }..removeWhere((key, value) => value == null);
  try {
    final response = await httpClient.get(
        path: "/channels/$id/messages", queryParameters: queries);

    if (includeUsers != null && includeUsers) {
      final messages =
          List<Message>.from(jsonDecode(response.body)["messages"].map((v) {
        return Message.fromJson(v);
      }));
      final users = List<RelationUser>.from(jsonDecode(response.body)["users"].map((v) {
        return RelationUser.fromJson(v);
      }));
      return (messages,users);
    }else{
       final messages =
          List<Message>.from(jsonDecode(response.body).map((v) {
        return Message.fromJson(v);
      }));
     
      return (messages,<RelationUser>[]);
    }

  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<Message> sendMessage(
    {required RevHttpClient httpClient,
    required String channelId,
    required String content,
    required String idempotencyKey}) async {
  final body = json.encode({
    "content": content,
  });
  final headers = {
    "Idempotency-Key": idempotencyKey,
  };

  try {
    final response = await httpClient.post(
        path: "/channels/$channelId/messages", headers: headers, body: body);
    return Message.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}
