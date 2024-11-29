import 'package:revolt_client/src/auth_repo/auth_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'models/models.dart';

class RevoltClient {
  final RevHttpClient clientConfig;
  RevAuth revAuth;

  RevoltClient({httpClient, clientConfig})
      : clientConfig = clientConfig ?? RevHttpClient(httpClient: httpClient),
        revAuth = RevAuth();

  login(
          {required String email,
          String? password,
          String? challenge,
          String? friendlyName,
          String? captcha}) async =>
      revAuth.login(clientConfig,
          email: email,
          password: password,
          challenge: challenge,
          friendlyName: friendlyName,
          captcha: captcha);

  verifyAccount({required String verificationCode}) async =>
      revAuth.verifyAccount(clientConfig, verificationCode);

  signUp(
          {required String email,
          required String password,
          String? invite,
          String? captcha}) async =>
      revAuth.signUp(
        clientConfig,
        email: email,
        password: password,
        captcha: captcha,
        invite: invite,
      );

  BehaviorSubject<AuthStatus> get authEvents => revAuth.authEvents;
}
