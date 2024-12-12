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

void main() {
  group('auth', () {
    test('returns Session details if the login completes succesfully', () async {
      final config = RevConfig.debug();
      final mockClient = MockClient();
      final prefs = MockSharedPreferencesAsync();
      final ws = MockWebSocketChannel();
      final revoltClient = RevoltClient(
        httpClient: mockClient,
        clientConfig: config,
        sharedPreferences: prefs,
        wsChannel: ws,
      );
     await revoltClient.init();
      final requestBody = {
        'email': 'myemail.example.cm',
        'password': 'securePassword@123',
      };
      when(
        mockClient.post(
          Uri.parse(
            'http://${config.baseUrl}:${config.httpPort}/auth/session/login',
          ),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '''{"result":"Success","_id":"01FNEVYZQGP2KT62SKVVF7WHW8","user_id":"01FN6NZ4PJRE55128RHC7FTVSC","token":"YOgo7yqjO8zGKs5l-iZimvrLib25Dd7WNxQetuMbXTN9lhp1eA609T_C5Q_butM6","name":"Unknown"}''',
          200,
        ),
      );

      await revoltClient.login(
        email: 'myemail.example.cm',
        password: requestBody['password'],
      );
      await expectLater(revoltClient.authEvents, emits(AuthStatus.authsucess));
    });
  });
}
