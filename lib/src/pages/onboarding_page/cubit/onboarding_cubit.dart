import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/src/revolt_client_base.dart';

part 'onboarding_state.dart';
part 'onboarding_cubit.freezed.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.client}) : super(OnboardingState());
  final RevoltClient client;

  void usernameChanged(String username) {
    emit(state.copyWith(username: username));
  }

  void submit()async {
    await client.completeOnboarding(username: state.username);
  }
}
