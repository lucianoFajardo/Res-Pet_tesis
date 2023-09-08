import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:respet_app/src/Models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(UserInitialState()) {
    on<ActivateUser>((event, emit) {
      print("activateuser call");
      emit(UserSetState(event.user));
    });
  }
}
