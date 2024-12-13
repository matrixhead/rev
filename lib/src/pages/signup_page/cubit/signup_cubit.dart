import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'signup_state.dart';
part 'signup_cubit.freezed.dart';

class SignupCubit extends Cubit<SignupState> {
  final RevoltClient _client;
  SignupCubit({required RevoltClient client})
      : _client = client,
        super(SignupState());

  emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void verificationCodeChanged(String verificationCode) {
     emit(state.copyWith(verificationCode: verificationCode));
  }

  void onSubmit()async {
    _client.signUp(email: state.email, password: state.password);
    emit(state.copyWith(signupCompleted: true));
  }

 Future<void> verificationCodeSubmit() async {
   await _client.verifyAccount(verificationCode: state.verificationCode);
   emit(state.copyWith(verificationCompleted: true));
  }
}
