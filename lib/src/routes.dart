import 'package:flutter/material.dart';
import 'package:rebar/src/pages/home_page/home.dart';
import 'package:rebar/src/pages/login_page/login_page.dart';
import 'package:rebar/src/pages/signup_page/signup_page.dart';
import 'pages/splash/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashPage.route: (context) => const SplashPage(),
  HomePage.route: (context) => const HomePage(),
  LoginPage.route: (context) => const LoginPage(),
  SignupPage.route:(context) => const SignupPage(),
};
