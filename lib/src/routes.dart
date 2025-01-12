import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rev/src/pages/home_page/home.dart';
import 'package:rev/src/pages/login_page/login_page.dart';
import 'package:rev/src/pages/onboarding_page/onboarding_page.dart';
import 'package:rev/src/pages/signup_page/signup_page.dart';
import 'pages/splash/splash.dart';

GoRouter getRouter() {
  return GoRouter(
    initialLocation: SplashPage.route,
    routes: <RouteBase>[
      GoRoute(
        path: SplashPage.route,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: HomePage.route,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
      GoRoute(
          path: LoginPage.route,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage(),
          routes: [
            GoRoute(
              name: SignupPage.route,
              path: SignupPage.route,
              builder: (BuildContext context, GoRouterState state) =>
                  const SignupPage(),
            ),
          ]),
      GoRoute(
        path: OnboardingPage.route,
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingPage(),
      ),
    ],
  );
}
