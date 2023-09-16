// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/bloc/login/login_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  User? user;
  bool _isLogOut = false;

  @override
  Widget build(BuildContext context) {
    final _inputPass = TextEditingController();
    final _inputUser = TextEditingController();

    Future createUser({
      required final String name,
      required final String contra,
    }) async {
      try {
        final res = await client.auth.signUp(email: name, password: contra);
      } catch (e) {
        print("error type : -> ${e}");
      }
    }

    Future _currentSession() async {
      setState(() {
        user = client.auth.currentUser;
      });
      client.auth.onAuthStateChange.listen((event) {
        if (event == AuthChangeEvent.signedIn) {
          print("user data LoginView: ${user!.email}");
          setState(() {
            _isLogOut = true;
          });
        }
      });
    }

    @override
    void initState() {
      _currentSession();
      super.initState();
    }
    
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
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
                    // Text(dotenv.get('SUPABASE_URL' , fallback: "not found url"))
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
                        
                        Esta funcion es de ingresar a su session
                        try {
                              final obj = await ingresar(
                                      name: _inputUser.text,
                                      pass: _inputPass.text)
                                  .then((value) {
                                Navigator.of(context)
                                    .pushReplacementNamed('home_view');
                              });
                            } catch (e) {
                              print("error because : ");
                            }
                        
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
                          onPressed: () async {
                            await context.read<LoginCubit>().SingInUser(
                                userName: _inputUser.text,
                                passUser: _inputPass.text,
                                contextClass: this.context);
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

                    _isLogOut
                        ? Text("Salir de la session",
                            style: TextStyle(color: Colors.green))
                        : Text(
                            "No se puede salir de la session",
                            style: TextStyle(color: Colors.red),
                          ),
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
