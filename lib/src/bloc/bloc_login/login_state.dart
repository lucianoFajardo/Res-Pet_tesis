part of 'login_bloc.dart';
//**
//Como luce la data como la modelo en el state para luego ocupara en los events y en el bloc
// 
// */
@immutable
abstract class LoginState {
  final bool existUser;
  final User? user;
  LoginState({this.existUser = false, this.user});
}

//? Creando la clase que inicializara los datos del usuarios
class loginInitialState extends LoginState {
  loginInitialState() : super(existUser: false, user: null);
}

class LoginLoading extends LoginState {  //! este codigo es para cuando la aplicacion este cargando.
  final bool newExistUser;
  LoginLoading({this.newExistUser = true});
}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState{
  final String? error;
  LoginError({required this.error});
}

//? aqui seteamos el usuario para poder ocuparlo
class loginSetState extends LoginState {
  final User newUser;
  loginSetState(this.newUser) : super(existUser: true, user: newUser);
}