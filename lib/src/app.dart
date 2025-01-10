import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev/src/common/bloc/app_bloc.dart';
import 'package:rev/src/pages/home_page/home.dart';
import 'package:rev/src/pages/login_page/login_page.dart';
import 'package:rev/src/pages/onboarding_page/onboarding_page.dart';
import 'package:rev/src/pages/splash/splash.dart';
import 'package:rev/src/routes.dart';
import 'package:rev/src/utils/theme/theme_builder.dart';
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
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final (lightTheme, darkTheme) =
            buildTheme(lightDynamic, darkDynamic);
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          navigatorKey: _navigatorKey,
          routes: routes,
          initialRoute: SplashPage.route,
          theme: lightTheme,
          darkTheme: darkTheme,
          builder: (context, child) {
            return BlocListener<AppBloc, AppState>(
              listener: (context, state) {
                switch (state.appStatus) {
                  case AppStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil(
                        HomePage.route, (route) => false);
                    break;
                  case AppStatus.notOnboarded:
                    _navigator.pushNamedAndRemoveUntil(
                        OnboardingPage.route, (route) => false);
                    break;
                  case AppStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil(
                        LoginPage.route, (route) => false);
                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
