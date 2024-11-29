import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/http_client.dart';
import 'package:revolt_client/src/models/api_error_response/api_error_response.dart';
import 'package:rxdart/subjects.dart';
import 'package:revolt_client/src/models/models.dart';

class RevAuth {
  BehaviorSubject<AuthStatus> authEvents = BehaviorSubject<AuthStatus>()
    ..add(AuthStatus.unknown);

  SessionDetails? session;

  login(RevHttpClient clientConfig,
      {required String email,
      String? password,
      String? challenge,
      String? friendlyName,
      String? captcha}) async {
    authEvents.add(AuthStatus.submitted);
    try {
      session = await api.login(clientConfig,
          email: email,
          password: password,
          challenge: challenge,
          friendlyName: friendlyName,
          captcha: captcha);
      authEvents.add(AuthStatus.authsucess);
    } on RevApiError catch (e) {
      authEvents.add(AuthStatus.authFailed);
      switch (e.errorResponse.errortype) {
        case ErrorType.unverifiedAccount:
          throw AccountNotVeifiedError();
        default:
          throw RevAuthError(e.errorResponse.errortype.toString());
      }
    }
  }

 Future<void> verifyAccount(RevHttpClient clientConfig, String verificationCode) async {
  try{
    return await api.verifyAccount(clientConfig, verificationCode);
  } on RevApiError catch (e){
    throw VerificationException(e.errorResponse.errortype.toString());
  }
  }

  signUp(RevHttpClient clientConfig,
      {required String email,
      required String password,
      String? invite,
      String? captcha}) async {
    try{
    await api.signUp(
      clientConfig,
      email: email,
      password: password,
      invite: invite,
      captcha: captcha,
    );
    } on RevApiError catch (e){
          throw SignUpException(e.errorResponse.errortype.toString()); 
    }
  }
}
