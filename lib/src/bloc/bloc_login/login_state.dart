part of 'login_bloc.dart';
//**
//Como luce la data como la modelo en el state para luego ocupara en los events y en el bloc
// 
// */

@immutable
abstract class LoginState {
  final bool existUser;
  final User? user;

  LoginState({
    this.existUser = false, 
    this.user
  });
}

//? Creando la clase que inicializara los datos del usuarios
class UserInitialState extends LoginState{
  UserInitialState() : super (existUser: false , user: null);
}

class UserSetState extends LoginState {
  final User newUser;
  UserSetState(this.newUser) : super (existUser: true , user: newUser);
}