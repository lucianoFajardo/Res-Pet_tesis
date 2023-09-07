// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      onPressed: () => print("enviar al menu principal"),
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
      ),
    );
  }
}
