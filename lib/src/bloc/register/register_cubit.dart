import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterInitial());

  // ignore: non_constant_identifier_names
  Future<void> RegisterUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());
      final res = await client.auth.signUp(
        email: email,
        password: password,
      );
      final idUser = res.user!.id;
      emit(RegisterSuccessfull(idUser: idUser));
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
