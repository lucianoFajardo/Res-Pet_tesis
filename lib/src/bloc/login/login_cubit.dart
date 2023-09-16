// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:respet_app/main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final clientSupabase = client;

  LoginCubit() : super(LoginInitial());

  Future<void> SingInUser({
    required String userName,
    required String passUser,
    required BuildContext contextClass,
  }) async {
    try {
      final userData = await clientSupabase.auth
          .signInWithPassword(email: userName, password: passUser);

          emit(LoginSuccesFull("acceso correcto"));
          
          if (userData.user != null) {
            Navigator.pushReplacementNamed(contextClass , 'home_view');
            print('si existe un usuario');
          }
    } catch (e) {
      emit(ErrorLogin("error: ${e}"));
    }
  }
}
