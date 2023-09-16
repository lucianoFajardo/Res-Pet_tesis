// ignore_for_file: must_be_immutable

part of 'login_cubit.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  final String? nombre;
  final String? pass;
  LoginInitial({this.nombre, this.pass});
  //LoginState copyWith({String? nombre, String? pass}) {
   // return LoginInitial(nombre: nombre ?? this.nombre, pass: pass ?? this.pass);
  //}
  @override
  List<Object> get props => [nombre!, pass!];
}

class LoginSetInitState extends LoginState {
  final String nombre;
  final String pass;
  LoginSetInitState({required this.nombre, required this.pass});
  @override
  List<Object> get props => [nombre, pass];
}

class LoginSuccesFull extends LoginState {
  final String teseccesfull;
  LoginSuccesFull(this.teseccesfull,);
    @override
  List<Object> get props => [teseccesfull];
}

class ErrorLogin extends LoginState {
  final String errorView;
  ErrorLogin(this.errorView);
  @override
  List<Object> get props => [errorView];
}
