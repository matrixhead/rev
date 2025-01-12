import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev/src/common/bloc/app_bloc.dart';
import 'package:rev/src/pages/home_page/home.dart';
import 'package:rev/src/pages/login_page/login_page.dart';
import 'package:rev/src/pages/onboarding_page/onboarding_page.dart';
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
  final _router = getRouter();
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final (lightTheme, darkTheme) = buildTheme(lightDynamic, darkDynamic);
        return BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.appStatus) {
              case AppStatus.authenticated:
                _router.go(HomePage.route);
                break;
              case AppStatus.notOnboarded:
                _router.go(OnboardingPage.route);
                break;
              case AppStatus.unauthenticated:
                _router.go(LoginPage.route);
                break;
            }
          },
          builder: (context, state) {
            return MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              routerConfig: _router,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: state.themeMode,
            );
          },
        );
      },
    );
  }
}
