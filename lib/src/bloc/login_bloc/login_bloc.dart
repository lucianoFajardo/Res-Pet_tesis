// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:respet_app/src/Models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInWithEmailButtonPressed>((event, emit) {
      print("LoginInWithEmailButtonPressed");
      emit(LoginSetState(event.user));
    });
  }
}
