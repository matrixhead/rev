import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:revolt_client/revolt_client.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final RevoltClient revoltClient;
  final updater = ShorebirdUpdater();
  late StreamSubscription<AuthStatus> _authenticationStatusSubscription;
  AppBloc({required this.revoltClient}) : super(const AppState()) {
    on<Init>(_onInit);
    on<AuthenticationStatusChanged>(_onAuthChanged);
    on<SetThemeMode>(_onSetThemeMode);
    _authenticationStatusSubscription = revoltClient.authEvents
        .listen((status) => add(AuthenticationStatusChanged(status)));
    add(Init());
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onInit(Init event, Emitter<AppState> emit) async {
    final patch = await updater.readCurrentPatch();
    emit(state.copyWith(patchNumber: patch?.number ));
  }

  void _onSetThemeMode(SetThemeMode event, Emitter<AppState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onAuthChanged(
    AuthenticationStatusChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.authStatus == AuthStatus.authsucess) {
      emit(state.copyWith(appStatus: AppStatus.authenticated));
    } else if (event.authStatus == AuthStatus.notOnboarded) {
      emit(state.copyWith(appStatus: AppStatus.notOnboarded));
    } else if (event.authStatus == AuthStatus.loggedout ||
        event.authStatus == AuthStatus.unknown) {
      emit(state.copyWith(appStatus: AppStatus.unauthenticated));
    }
  }
}
