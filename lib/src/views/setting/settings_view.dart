// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';
import 'package:respet_app/src/views/login/login_view.dart';

class SettingPageUI extends StatefulWidget {
  const SettingPageUI({super.key});

  @override
  State<SettingPageUI> createState() => _SettingPageUIState();
}

class _SettingPageUIState extends State<SettingPageUI> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _loginExitState = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones', style: TextStyle(fontSize: 22)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back, //flecha de regreso //
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
                    ),
                    SizedBox(width: 10),
                    Text("Mi Cuenta",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
                Divider(height: 20, thickness: 1),
                SizedBox(height: 10), //creador de separador de liena//
                buildAccountOption(context, "Cuenta"),
                buildAccountOption(context, "Privacidad"),
                buildAccountOption(context, 'Seguridad'),
                buildAccountOption(context, "lenguaje"),
                buildAccountOption(context, "Temas de Servicios"),
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(Icons.volume_up_outlined, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('Notifications',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
                Divider(height: 20, thickness: 1),
                SizedBox(
                  height: 10,
                ),
                buildNotificationOption(
                    "Nuevas Publicaciones", valNotify1, onChangeFunction1),
                buildNotificationOption(
                    "Previsualizar", valNotify2, onChangeFunction2),
                SizedBox(height: 15),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                      Future.delayed(Duration(seconds: 3), () {
                        _loginExitState.SingOut();
                        //TODO : Agregar la ruta para volver al login o cerrar la sesion.
                        //Navigator.popUntil(context, ModalRoute.withName('login'));
                      });
                    },
                    child: Text('Cerrar Cuenta',
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600])),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('opcion 1'), Text('opcion 2')],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'))
                ],
              );
            });
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
