part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, notOnboarded }

@immutable
class AppState extends Equatable {
  final AppStatus appStatus;
  final ThemeMode themeMode;

  const AppState({this.appStatus = AppStatus.unauthenticated, this.themeMode = ThemeMode.system});

  AppState copyWith({AppStatus? appStatus, ThemeMode? themeMode}) =>
      AppState(appStatus: appStatus ?? this.appStatus,themeMode:themeMode ?? this.themeMode );

  @override
  List<Object?> get props => [appStatus,themeMode];
}
