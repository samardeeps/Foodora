import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<InitializeSplash>(_onInitializeSplash);
    on<CompleteSplash>(_onCompleteSplash);
  }

  Future<void> _onInitializeSplash(
    InitializeSplash event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());
    await Future.delayed(const Duration(seconds: 5));
    add(const CompleteSplash());
  }

  void _onCompleteSplash(CompleteSplash event, Emitter<SplashState> emit) {
    emit(const SplashCompleted());
  }
}
