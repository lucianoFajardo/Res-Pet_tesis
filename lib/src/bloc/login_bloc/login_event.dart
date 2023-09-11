part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInWithEmailButtonPressed extends LoginEvent {
  final User user;
  final bool? userTrue;
  LoginInWithEmailButtonPressed({required this.user , this.userTrue});
}