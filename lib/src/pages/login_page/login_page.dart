import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/pages/login_page/cubit/login_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

import 'widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  static const route = "/login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(client:context.read<RevoltClient>()),
      child: const LoginPageView(),
    );
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(),
              Content(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
