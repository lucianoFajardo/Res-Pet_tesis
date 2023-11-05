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
    required String phone,
    required String name,
  }) async {
    try {
      // ignore: unused_local_variable
      emit(RegisterLoading());
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      await supabase.from('profile_data_user').insert({
        'user_name': name,
        'cellphone': phone,
      });
      emit(RegisterSuccessfull());
      // ignore: avoid_print
      print("Usuario Registrado");
    } catch (e) {
      emit(RegisterFailed(e.toString()));
      // ignore: avoid_print
    }
  }
}
