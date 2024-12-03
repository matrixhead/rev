import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rebar/src/app.dart';
import 'package:revolt_client/revolt_client.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final config = RevConfig.debug().copyWith(baseUrl:"192.168.0.114"); 
  final revoltClient = RevoltClient(clientConfig: config);
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
