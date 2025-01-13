part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, notOnboarded }

@immutable
class AppState extends Equatable {
  final AppStatus appStatus;
  final ThemeMode themeMode;
  final int patchNumber;

  const AppState(
      {this.appStatus = AppStatus.unauthenticated,
      this.themeMode = ThemeMode.system,
      this.patchNumber = 0});

  AppState copyWith({AppStatus? appStatus, ThemeMode? themeMode, int? patchNumber}) => AppState(
      appStatus: appStatus ?? this.appStatus,
      themeMode: themeMode ?? this.themeMode,
      patchNumber: patchNumber ?? this.patchNumber,
      );

  @override
  List<Object?> get props => [appStatus, themeMode, patchNumber];
}
