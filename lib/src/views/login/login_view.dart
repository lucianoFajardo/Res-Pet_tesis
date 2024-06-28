// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, use_build_context_synchronously, avoid_print
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
            duration: const Duration(seconds: 2),
          ),
        );
      }
      if (state is LoginSuccesFull) {
        Navigator.pushReplacementNamed(context, 'home_view');
      }
    }, builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        ));
      } else {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 320,
                    child: Image.asset('assets/respetlogo.png'),
                  ),
                  SizedBox(
                    width: double
                        .maxFinite, //! tener en cuenta esto para las posibles actualizaciones de pantalla que se tengan.
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                        child: Text("Inicio de sesión ResPet",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
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
                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: MaterialButton(
                        height: 50,
                        color: Colors.amber[300],
                        onPressed: () {
                          _loginCubitState.SingInUser(
                              userName: _inputUser.text,
                              passUser: _inputPass.text);
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
                        color: Colors.amber[300],
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                ],
              ),
            ),
          ],
        );
      }
    }));
  }
}
