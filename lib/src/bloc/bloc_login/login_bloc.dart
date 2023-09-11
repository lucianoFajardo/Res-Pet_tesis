import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:respet_app/src/Models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(loginInitialState()) {
    on<ActivateUser>((event, emit) {
      print("activateUser call");
      //emit(UserSetState(event.user));
    });

    on<LoginInWithEmailButtonPressed>((event, emit) {
      print((
        "🚀 ~ file: login_bloc.dart:18 ~ LoginBloc ~ LoginBloc ~ LoginInWithEmailButtonPressed:",
        LoginInWithEmailButtonPressed
      ));
      emit(loginSetState(event.user));
    });
  }
}


//TODO : cambiar de rama en git una vez el proyecto este finalizado con el bloc para poder mandar todos los cambios bien.