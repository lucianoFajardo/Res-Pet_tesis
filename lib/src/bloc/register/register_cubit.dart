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
    required String lastName,
    required String? address,

  }) async {
    try {
      // ignore: unused_local_variable
      final AuthResponse respositorio = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"Nombre": name, "Apellido": lastName, "Celular": phone,"Direccion": address}
      );

      emit(RegisterSuccessfull());
      // ignore: avoid_print
      print("Usuario Registrado");

    } catch (e) {
      emit(RegisterFailed(e.toString()));
      // ignore: avoid_print
      print("Error: $e");

    }
  }

  
}
