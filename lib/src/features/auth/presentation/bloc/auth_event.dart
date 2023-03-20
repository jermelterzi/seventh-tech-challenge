part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final User user;

  const LoginEvent(this.user);

  @override
  List<Object> get props => [user];
}
