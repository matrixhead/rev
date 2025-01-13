import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev/src/common/widgets/form_text_field.dart';
import 'package:rev/src/common/widgets/googly_eyes.dart';
import 'package:rev/src/common/widgets/primary_button.dart';
import 'package:rev/src/pages/onboarding_page/cubit/onboarding_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class OnboardingPage extends StatelessWidget {
  static const String route = "/onboarding";
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    return Center(
                        child: FittedBox(
                            child: GooglyEyesAnimated(
                                seed: state.username.hashCode, size: 200)));
                  },
                ),
              ),
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
      ),
    );
  }
}
