import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:revolt_client/revolt_client.dart';

typedef Client = http.Client;
(String, String) registerLoginStub(Client client, RevConfig config) {
  when(
    client.post(
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
  return ('myemail.example.cm', 'securePassword@123');
}

void registerOnboardingStub(
  Client client,
  RevConfig config, {
  required bool onboardingStatus,
}) {
  when(
    client.get(
      Uri.parse('http://${config.baseUrl}:${config.httpPort}/onboard/hello'),
      headers: anyNamed('headers'),
    ),
  ).thenAnswer(
    (_) async =>
        http.Response(jsonEncode({'onboarding': onboardingStatus}), 200),
  );
}
