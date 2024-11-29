import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/exceptions/exceptions.dart';
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

  Future<CurrentUser> completeOnboarding(RevHttpClient httpClient,String username) {
    try {
      return api.completeOnboarding(httpClient,username);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }
}
