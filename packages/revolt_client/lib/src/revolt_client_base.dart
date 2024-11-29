import 'package:revolt_client/src/auth/auth.dart';
import 'package:revolt_client/src/data/data.dart';
import 'package:revolt_client/src/models/user/user.dart';
import 'package:rxdart/rxdart.dart';
import 'models/models.dart';

class RevoltClient {
  final RevHttpClient httpClient;
  final RevAuth revAuth;
  final RevData revData;

  RevoltClient({httpClient, clientConfig})
      : httpClient = clientConfig ?? RevHttpClient(httpClient: httpClient),
        revAuth = RevAuth(),
        revData = RevData() {
    _init();
  }

  _init() {
    listenOnAuthEvents();
  }

  listenOnAuthEvents() {
    revAuth.authEvents.listen((authEvent) {
      if (authEvent == AuthStatus.authsucess) {
        httpClient.setToken = revAuth.session!.sessionToken;
      } else {
        httpClient.setToken = null;
      }
    });
  }

  login(
          {required String email,
          String? password,
          String? challenge,
          String? friendlyName,
          String? captcha}) async =>
      revAuth.login(httpClient,
          email: email,
          password: password,
          challenge: challenge,
          friendlyName: friendlyName,
          captcha: captcha);

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
  Future<CurrentUser> completeOnboarding({required String username}) async => revData.completeOnboarding(httpClient,username);

  BehaviorSubject<AuthStatus> get authEvents => revAuth.authEvents;
}
