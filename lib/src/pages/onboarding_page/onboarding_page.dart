import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/common/widgets/form_text_field.dart';
import 'package:rebar/src/common/widgets/primary_button.dart';
import 'package:rebar/src/pages/onboarding_page/cubit/onboarding_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class OnboardingPage extends StatelessWidget {
  static const String route = "onboarding";
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnboardingCubit(client: context.read<RevoltClient>()),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FormTextField(
                    label: "Username",
                    onChanged:
                        context.read<OnboardingCubit>().usernameChanged,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      context.read<OnboardingCubit>().submit();
                    },
                    label: "Verify",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
