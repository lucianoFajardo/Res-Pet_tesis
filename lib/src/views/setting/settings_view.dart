// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';
import 'package:respet_app/src/views/setting/account_view.dart';

class SettingPageUI extends StatefulWidget {
  const SettingPageUI({super.key});

  @override
  State<SettingPageUI> createState() => _SettingPageUIState();
}

class _SettingPageUIState extends State<SettingPageUI> {
  @override
  Widget build(BuildContext context) {
    final loginExitState = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones', style: TextStyle(fontSize: 22)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios, //flecha de regreso //
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is ErrorExit) {
            return Center(child: Text("error: ${state.errorView.toString()}"));
          }
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${client.auth.currentSession!.user.email}",
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )
                  ],
                ),
                Divider(height: 20, thickness: 1),
                SizedBox(height: 10),
              buildRouterPage(context, "Cuenta", 'view_account'),  //TODO : Aqui esta la ruta para ver los datos de cuenta
              buildRouterPage(context, "Mis publicaciones", 'view_my_publications'),
                SizedBox(height: 40),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.amber[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                      Future.delayed(Duration(seconds: 1), () {
                        loginExitState.SingOut();
                        //TODO : Agregar la ruta para volver al login o cerrar la sesion.
                        //Navigator.popUntil(context, ModalRoute.withName('login'));
                        Navigator.pushReplacementNamed(context, 'login');
                      });
                    },
                    child: Text(
                      'Cerrar cuenta',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  GestureDetector buildRouterPage(
      BuildContext context, String title, String routePage) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routePage);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward_ios, color: Colors.blue)
          ],
        ),
      ),
    );
  }
}

