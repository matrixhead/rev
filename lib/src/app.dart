import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/common/bloc/app_bloc.dart';
import 'package:rebar/src/routes.dart';
import 'package:rebar/src/utils/theme/theme_builder.dart';
import 'package:revolt_client/revolt_client.dart';

class MyApp extends StatelessWidget {
  final RevoltClient revoltClient;
  const MyApp({
    required this.revoltClient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: revoltClient,
        child: BlocProvider(
          create: (context) => AppBloc(revoltClient: revoltClient),
          child: const AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      navigatorKey: _navigatorKey,
      routes: routes,
      initialRoute: "/",
      theme: buildDefaultTheme(),
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.appStatus) {
              case AppStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil('/home', (route) => false);
                break;
              case AppStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil('/login', (route) => false);
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
