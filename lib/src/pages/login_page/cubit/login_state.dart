part of 'login_cubit.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
  }) = _LoginState;
} 