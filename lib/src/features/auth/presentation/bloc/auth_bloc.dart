import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_monitoring_seventh/src/core/domain/usecases/usecase.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UseCase<Unit, User> loginUseCase;

  AuthBloc({
    required this.loginUseCase,
  }) : super(
          AuthInitial(
            user: User(
              id: '',
              username: '',
              password: '',
            ),
          ),
        ) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading(user: event.user));

    final loginResult = await loginUseCase(event.user);

    loginResult.fold(
      (failure) {
        emit(
          AuthError(
            user: event.user,
            errorMessage: failure.message,
          ),
        );
      },
      (_) => emit(
        AuthSuccess(user: event.user),
      ),
    );
  }
}
