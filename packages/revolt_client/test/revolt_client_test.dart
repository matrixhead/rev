import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:revolt_client/revolt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<SharedPreferencesAsync>(),
  MockSpec<WebSocketChannel>(),
])
import 'revolt_client_test.mocks.dart';
import 'stubs.dart';

void main() {
  late RevConfig config;
  late http.Client mockhttpClient;
  late WebSocketChannel ws;
  late RevoltClient revoltClient;
  late SharedPreferencesAsync prefs;

  setUp(() async {
    config = RevConfig.debug();
    mockhttpClient = MockClient();
    prefs = MockSharedPreferencesAsync();
    ws = MockWebSocketChannel();
    revoltClient = RevoltClient(
      httpClient: mockhttpClient,
      clientConfig: config,
      sharedPreferences: prefs,
      wsChannel: ws,
    );
    await revoltClient.init();
  });
  group('auth', () {
    test('emits auth success if the login completes succesfully', () async {
      final (email, password) = registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: false);
      await revoltClient.login(email: email, password: password);
      await expectLater(revoltClient.authEvents, emits(AuthStatus.authsucess));
    });
    test('emits notOnboarded', () async {
      final (email, password) = registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: true);
      await revoltClient.login(email: email, password: password);
      await expectLater(
        revoltClient.authEvents,
        emits(AuthStatus.notOnboarded),
      );
    });

    test('emits authsuccess after onboarding', () async {
      final requestBody = {
        'email': 'myemail.example.cm',
        'password': 'securePassword@123',
      };
      when(
        mockhttpClient.post(
          Uri.parse(
            'http://${config.baseUrl}:${config.httpPort}/auth/session/login',
          ),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{'
          '"result":"Success",'
          '"_id":"01FNEVYZQGP2KT62SKVVF7WHW8",'
          '"user_id":"01FN6NZ4PJRE55128RHC7FTVSC",'
          '"token":"YOgo7yqjO8zGKs5l-iZimvrLib",'
          '"name":"Unknown"'
          '}',
          200,
        ),
      );

      when(
        mockhttpClient.get(
          Uri.parse(
            'http://${config.baseUrl}:${config.httpPort}/onboard/hello',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{'
          '"onboarding":true'
          '}',
          200,
        ),
      );

      await revoltClient.login(
        email: 'myemail.example.cm',
        password: requestBody['password'],
      );
      await expectLater(
        revoltClient.authEvents,
        emits(AuthStatus.notOnboarded),
      );

      when(
        mockhttpClient.get(
          Uri.parse(
            'http://${config.baseUrl}:${config.httpPort}/onboard/hello',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{'
          '"onboarding":true'
          '}',
          200,
        ),
      );

      await revoltClient.completeOnboarding(username: 'myUserName');

      await expectLater(revoltClient.authEvents, emits(AuthStatus.authsucess));
    });
  });
}
