import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/api_error_response/api_error_response.dart';
import 'package:revolt_client/src/models/models.dart';
import 'package:revolt_client/src/state/rev_state.dart';

class RevAuth {
  RevAuth({required RevState state, required RevHttpClient revHttpClient})
    : _state = state,
      _revHttpClient = revHttpClient;

  final RevState _state;
  final RevHttpClient _revHttpClient;

  Future<void> login({
    required String email,
    String? password,
    String? challenge,
    String? friendlyName,
    String? captcha,
  }) async {
    _state.authRepo.authEvents.add(AuthStatus.submitted);
    try {
      _state.authRepo.session = await api.login(
        _revHttpClient,
        email: email,
        password: password,
        challenge: challenge,
        friendlyName: friendlyName,
        captcha: captcha,
      );
      _state.authRepo.authEvents.add(AuthStatus.authsucess);
    } on RevApiError catch (e) {
      _state.authRepo.authEvents.add(AuthStatus.authFailed);
      switch (e) {
        case RevApiErrorWithResponse(
              errorResponse: final ApiErrorResponse error,
            )
            when error.errortype == ErrorType.unverifiedAccount:
          throw AccountNotVeifiedError();
        default:
          throw RevAuthError(e.toString());
      }
    }
  }

  void setSession(SessionDetails session) {
    _state.authRepo.session = session;
    _state.authRepo.authEvents.add(AuthStatus.authsucess);
  }

  Future<void> verifyAccount(String verificationCode) async {
    try {
      return await api.verifyAccount(_revHttpClient, verificationCode);
    } on RevApiError catch (e) {
      throw VerificationException(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? invite,
    String? captcha,
  }) async {
    try {
      await api.signUp(
        _revHttpClient,
        email: email,
        password: password,
        invite: invite,
        captcha: captcha,
      );
    } on RevApiError catch (e) {
      throw SignUpException(e.toString());
    }
  }
}
