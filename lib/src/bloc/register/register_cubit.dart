import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final supabase = Supabase.instance.client;

  RegisterCubit() : super(RegisterInitial());

  // ignore: non_constant_identifier_names
  Future<void> RegisterUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final idUser = res.user!.id;
      print(idUser);
      emit(RegisterSuccessfull(idUser: idUser));
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
