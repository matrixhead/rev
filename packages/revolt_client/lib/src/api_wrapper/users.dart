import 'dart:convert';

import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/http_client.dart';
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
  RevHttpClient clientConfig,
  String username
) async {
   final body = json.encode({
    "username": username,
  });
  try {
    final response = await clientConfig.post(path: "/onboard/complete",body: body);
    return CurrentUser.fromJson(jsonDecode(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}