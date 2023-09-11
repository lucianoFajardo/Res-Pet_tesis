part of 'login_bloc.dart';
//**
//Los eventos que se van a disparar al momento de realizar una accion ya sea tocar el boton de register y mandar la data o cualquier 
// otra accion que dispare este evento en particular.
// */

@immutable
abstract class LoginEvent {}

class ActivateUser extends LoginEvent {
  final User user;  //? User ya trae los campos nombre y contraseña integrados dentro de si asi que no es necesario llamarlos dos veces
  ActivateUser(this.user);
}

class LoginInWithEmailButtonPressed extends LoginEvent {
  final User user;
  LoginInWithEmailButtonPressed({required this.user});
}