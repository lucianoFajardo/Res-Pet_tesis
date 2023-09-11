part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInWithEmailButtonPressed extends LoginEvent {
  final User user;
  LoginInWithEmailButtonPressed({required this.user});
}