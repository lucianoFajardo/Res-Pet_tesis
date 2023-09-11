part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  final bool existUser;
  final User? user;
  LoginState({required this.existUser, required this.user});
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super(existUser: false, user: null);
}

class LoginSetState extends LoginState {
  final User newUser;
  LoginSetState(this.newUser) : super(existUser: true, user: newUser);
}

