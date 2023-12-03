// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/register/register_cubit.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({super.key});

  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  bool isVisible = false;
  bool isPasswordCharacter = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  passwordChanged(String password) {
    setState(() {
      if (password.length >= 8) {
        isPasswordCharacter = true;
      } else {
        isPasswordCharacter = false;
      }
      if (password.isEmpty) {
        _formKey.currentState?.validate();
      } else {
        password.isNotEmpty;
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final registerCubitState = BlocProvider.of<RegisterCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrate', style: TextStyle(fontSize: 22)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
        if (state is RegisterFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorView.toString()),
              duration: Duration(seconds: 4),
            ),
          );
        }
        if (state is RegisterSuccessfull) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registrado con Exito"),
              duration: Duration(seconds: 4),
            ),
          );
          Navigator.pushReplacementNamed(context, 'register_data_user');
        }
      }, builder: (context, state) {
        if (state is RegisterLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Correo Electronico",
                            hintText: "Ingresar Correo Electronico"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Llene la casilla";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Ingrese un Correo Electronico valido.";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _formKey.currentState?.validate();
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        onChanged: (valuePassword) =>
                            passwordChanged(valuePassword),
                        controller: passwordController,
                        obscureText: !isVisible,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Contraseña",
                          hintText: "Ingresar Contraseña",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? Icon(Icons.visibility, color: Colors.black87)
                                : Icon(Icons.visibility_off,
                                    color: Colors.grey),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingresar una contraseña valida ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isPasswordCharacter
                                  ? Colors.green[700]
                                  : Colors.transparent,
                              border: isPasswordCharacter
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text("Debe contener al menos 8 caracteres"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 60,
                          width: 150,
                          child: MaterialButton(
                            height: 50,
                            color: Colors.amber[300],
                            onPressed: () async {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              if (_formKey.currentState!.validate() &&
                                  isPasswordCharacter == true) {
                                registerCubitState.RegisterUser(
                                  email: email,
                                  password: password,
                                );
                              }
                              clearForm();
                            },
                            child: Text("Registrarse"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    isPasswordCharacter = false;
  }
}
