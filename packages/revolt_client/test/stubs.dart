import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:revolt_client/revolt_client.dart';

typedef Client = http.Client;

void registerLoginStub(Client client, RevConfig config) {
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

void registerSignupStub(Client client, RevConfig config) {
  when(
    client.post(
      Uri.parse(
        'http://${config.baseUrl}:${config.httpPort}/auth/account/create',
      ),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => http.Response('', 204));
}

void registerverifyStub(
  Client client,
  RevConfig config,
  String verificationCode,
) {
  when(
    client.post(
      Uri.parse(
        'http://${config.baseUrl}:${config.httpPort}/auth/account/verify/$verificationCode',
      ),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => http.Response('', 200));
}

void registerCompleteOnboardingStub(
  Client client,
  RevConfig config,
  String username,
) {
  final responseBody = {
    '_id': '01JFA9RPGMRVXDNDMMXGZGTVQ7',
    'username': 'myuser',
    'discriminator': '3549',
    'relationship': 'User',
    'online': false,
  };
  when(
    client.post(
      Uri.parse('http://${config.baseUrl}:${config.httpPort}/onboard/complete'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => http.Response(jsonEncode(responseBody), 200));
}
