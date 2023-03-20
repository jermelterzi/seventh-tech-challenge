part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final User user;

  const AuthState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthInitial extends AuthState {
  const AuthInitial({required super.user});
}

class AuthLoading extends AuthState {
  const AuthLoading({required super.user});
}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError({
    required super.user,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [super.props, errorMessage];
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required super.user});
}
