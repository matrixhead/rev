part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AuthenticationStatusChanged extends AppEvent {
  final AuthStatus authStatus;
  AuthenticationStatusChanged(this.authStatus);
}

class SetThemeMode extends AppEvent {
  final ThemeMode themeMode;

  SetThemeMode({required this.themeMode});
}

class Init extends AppEvent{
}
