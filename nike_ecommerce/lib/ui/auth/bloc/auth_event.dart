part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}
class AuthStarted extends AuthEvent{}

class AuthButtonIsClicked extends AuthEvent{
  final String username;
  final String password;

  AuthButtonIsClicked(this.username, this.password);
}

class AuthModeChangeIsClicked extends AuthEvent{}
