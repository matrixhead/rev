import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev/src/common/widgets/form_text_field.dart';
import 'package:rev/src/common/widgets/primary_button.dart';
import 'package:rev/src/pages/signup_page/cubit/signup_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class SignupPage extends StatelessWidget {
  static const route = "/signup";
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(client: context.read<RevoltClient>()),
      child: SignupPageView(),
    );
  }
}

class SignupPageView extends StatelessWidget {
  const SignupPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.verificationCompleted) Navigator.of(context).pop();
          },
          builder: (context, state) {
            return state.signupCompleted ? VerificationForm() : SignupForm();
          },
        ),
      ),
    );
  }
}

class VerificationForm extends StatelessWidget {
  const VerificationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FormTextField(
                label: "Verification code",
                onChanged: context.read<SignupCubit>().verificationCodeChanged,
              ),
              PrimaryButton(
                onPressed: () {
                  context.read<SignupCubit>().verificationCodeSubmit();
                },
                label: "Verify",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FormTextField(
                label: "Email",
                onChanged: context.read<SignupCubit>().emailChanged,
              ),
              FormTextField(
                label: "Password",
                onChanged: context.read<SignupCubit>().passwordChanged,
              ),
              PrimaryButton(
                onPressed: context.read<SignupCubit>().onSubmit,
                label: "Signup",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
