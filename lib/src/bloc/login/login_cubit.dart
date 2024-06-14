// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print, prefer_const_constructors
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final clientSupabase = client;
  LoginCubit() : super(LoginInitial());

  Future<void> SingInUser({
    required String userName,
    required String passUser,
  }) async {
    try {
      emit(LoginLoading());
      final userData = await clientSupabase.auth
          .signInWithPassword(email: userName, password: passUser);
      if (userData.user != null) {
        emit(LoginSuccesFull());
      }
    } on AuthException catch (_) {
      emit(ErrorLogin("Credenciales invalidas intente de nuevo"));
    } catch (e) {
      emit(ErrorLogin("Error inseperado :( "));
    }
  }

  Future<void> SingOut() async {
    try {
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 2));
      await client.auth.signOut();
      emit(LoginExitSuccesfull());
    } on AuthResponse catch (e) {
      emit(ErrorExitUser('$e'));
    } catch (e) {
      emit(ErrorExitUser('$e'));
    }
  }
}
