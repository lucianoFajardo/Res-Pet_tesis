// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final _loginCubitState = BlocProvider.of<LoginCubit>(context);

    final _inputPass = TextEditingController();
    final _inputUser = TextEditingController();

    return Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is ErrorLogin) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorView.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      }
      if (state is LoginSuccesFull) {
        Navigator.pushReplacementNamed(context, 'home_view');
        print("LoginSuccesfull : -> user navigater login");
      }
    }, builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
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
                      onChanged: (value) {},
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
                      controller: _inputPass,
                      onChanged: (value) {
                        print(value);
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Contraseña',
                        hintText: 'Ingrese su contraseña',
                      ),
                    ),
                  ),

                  /**                Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: MaterialButton(
                                  height: 50,
                                  color: Colors.amber,
                                  onPressed: () async {
                                    // aqui va toda la logica 🤨  de supabase
                                    try {
                                      final obj1 = await createUser(
                                          name: _inputUser.text, contra: _inputPass.text);
                                      print(obj1);
                                    } catch (e) {
                                      print("error create user because :  ");
                                    }
                                  },
                                  child: const Text(
                                    'Iniciar sesion',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                              
                                */

                  //TODO: habilitar el boton para agregar un usuario

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
                          _loginCubitState.SingInUser(
                              userName: _inputUser.text,
                              passUser: _inputPass.text);
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
                  ),
                ],
              ),
            ),
          ],
        );
      }
    }));
  }
}
