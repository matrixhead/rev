part of 'signup_cubit.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    @Default("") String email,
    @Default("") String password,
    @Default("") String verificationCode,
    @Default(false) bool signupCompleted,
    @Default(false) bool verificationCompleted
  }) = _SignupState;
}
