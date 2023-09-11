// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/Models/user_model.dart';
import 'package:respet_app/src/bloc/login_bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final _inputPass = TextEditingController();
    final _inputUser = TextEditingController();

    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (_, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //? aqui va el logo
                    Padding(
                        padding: EdgeInsets.only(top: 80, bottom: 10),
                        child: SizedBox(
                          width: 150,
                          height: 200,
                          child: Card(
                              child: Text(
                            'logo',
                            textAlign: TextAlign.center,
                          )),
                        )),
                    SizedBox(
                      width: double
                          .maxFinite, //! tener en cuenta esto para las posibles actualizaciones de pantalla que se tengan.
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Inicio de sesión",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _inputUser,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Correo electronico',
                          hintText: 'Ingrese su correo',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _inputPass,
                        obscureText: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Contraseña',
                          hintText: 'Ingrese su contraseña',
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: MaterialButton(
                          height: 50,
                          color: Colors.amber,
                          onPressed: () {
                            final userSend = User(
                                name: _inputUser.value.text,
                                pass: _inputPass.value.text);
                            //! dentro de este boton puedo llamara a las funciones que se necesitan para ocupar la data ejemplo seria pasar los campos que necesito renderizar como nombre y estado
                            BlocProvider.of<LoginBloc>(context, listen: false)
                                .add(LoginInWithEmailButtonPressed(
                                    user: userSend));

                            Navigator.pushNamed(context, 'home_view');
                          },
                          child: const Text(
                            'Iniciar sesion',
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                      child: Text("o"),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: MaterialButton(
                          height: 50,
                          color: Colors.amber,
                          onPressed: () {
                            print("");
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Registrate',
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 90),
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: const BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            onPressed: () {
                              print('Pressed');
                            },
                            child: Text('¿Olvidaste tu contraseña? Te ayudamos',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          "los datos de la aplicación como los terminos y condiciones que se ocuparanal desarrollar la app"),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
