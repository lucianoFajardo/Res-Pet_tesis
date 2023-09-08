part of 'login_bloc.dart';
//**
//Los eventos que se van a disparar al momento de realizar una accion ya sea tocar el boton de register y mandar la data o cualquier 
// otra accion que dispare este evento en particular.
// */

@immutable
abstract class LoginEvent {}

class ActivateUser extends LoginEvent {
  final User user;
  ActivateUser(this.user);
}