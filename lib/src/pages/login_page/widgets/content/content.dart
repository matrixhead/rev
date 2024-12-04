import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/pages/login_page/cubit/login_cubit.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LoginTextField(
            label: "Email",
            onChanged: context.read<LoginCubit>().emailChanged,
          ),
          LoginTextField(
            label: "Password",
            onChanged: context.read<LoginCubit>().passwordChanged,
          ),
          ElevatedButton(
            onPressed: context.read<LoginCubit>().onSubmit,
            child: AspectRatio(
              aspectRatio: 5,
              child: Center(child: const Text("Login")),
            ),
          )
        ],
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String label;
  final void Function(String)? onChanged;

  const LoginTextField({super.key, required this.label, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          onChanged: onChanged,
        ),
      ],
    );
  }
}
