// ignore_for_file: must_be_immutable

part of 'login_cubit.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginSetInitState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccesFull extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginExitSuccesfull extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ErrorLogin extends LoginState {
  final String errorView;
  ErrorLogin(this.errorView);
  @override
  List<Object> get props => [errorView];
}

class ErrorExitUser extends LoginState {
  final String exitUser;
  ErrorExitUser(this.exitUser);
  @override
  // TODO: implement props
  List<Object?> get props => [exitUser];
}

class ErrorExit extends LoginState {
  final String errorView;
  ErrorExit(this.errorView);
  @override
  List<Object> get props => [errorView];
}
