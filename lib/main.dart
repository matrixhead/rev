import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rev/src/app.dart';
import 'package:revolt_client/revolt_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // final config = RevConfig.debug().copyWith(baseUrl:"192.168.0.114");
  final config = RevConfig(
    https: true,
    baseUrl: "140.245.7.114",
    wsUrl: "140.245.7.114/revolt/ws",
    pathPrefix: "/revolt/api",
    email: false
  );
  final revoltClient = RevoltClient(clientConfig: config)
    ..loginFromSavedState();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      path: 'assets/translations',
      child: MyApp(revoltClient: revoltClient),
    ),
  );
}
