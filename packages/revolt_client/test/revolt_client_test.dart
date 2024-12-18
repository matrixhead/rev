import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:revolt_client/revolt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dummy.dart';
@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<SharedPreferencesAsync>(),
  MockSpec<WebSocketChannel>(as: #$MockWebSocketChannel),
])
import 'revolt_client_test.mocks.dart';
import 'stubs.dart';

const noMock = (String.fromEnvironment('NO-MOCK') == 'true');

class MockWebSocketChannel extends $MockWebSocketChannel {
  StreamController<dynamic> mockStreamController = StreamController.broadcast(
    sync: true,
  );
  @override
  Stream<dynamic> get stream {
    return mockStreamController.stream;
  }
}

void main() {
  late RevConfig config;
  late http.Client mockhttpClient;
  late WebSocketChannel ws;
  late RevoltClient revoltClient;
  late SharedPreferencesAsync prefs;

  setUp(() async {
    config = RevConfig.debug();
    prefs = MockSharedPreferencesAsync();
    mockhttpClient = MockClient();
    ws = MockWebSocketChannel();
    if (!noMock) {
      revoltClient = RevoltClient(
        httpClient: mockhttpClient,
        clientConfig: config,
        sharedPreferences: prefs,
        wsChannel: ws,
      );
    } else {
      revoltClient = RevoltClient(
        clientConfig: config,
        sharedPreferences: prefs,
      );
    }
    await revoltClient.init();
  });
  group('auth', () {
    test('signup', () async {
      registerSignupStub(mockhttpClient, config);
      await revoltClient.signUp(email: dummyEmail, password: dummyPassword);
    });

    test('verify account', () async {
      const verficationCode = 'HhIB4s1ObXyo4hPw3d2M8tHzAiDFBwn2';
      registerverifyStub(mockhttpClient, config, verficationCode);
      await revoltClient.verifyAccount(verificationCode: verficationCode);
    });

    test('emits auth success if the login completes succesfully', () async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: false);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      await expectLater(revoltClient.authEvents, emits(AuthStatus.authsucess));
    });

    test('emits notOnboarded', () async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: true);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      await expectLater(
        revoltClient.authEvents,
        emits(AuthStatus.notOnboarded),
      );
    });
    test('emits authsuccess after onboarding', () async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: true);
      registerCompleteOnboardingStub(mockhttpClient, config, dummyUsername);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      await expectLater(
        revoltClient.authEvents,
        emits(AuthStatus.notOnboarded),
      );
      await revoltClient.completeOnboarding(username: dummyUsername);
      await expectLater(revoltClient.authEvents, emits(AuthStatus.authsucess));
    });

    test('check', () async {});
  });
}
