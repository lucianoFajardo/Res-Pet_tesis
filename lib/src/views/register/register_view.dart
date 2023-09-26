// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/register/register_cubit.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _esVisible = false;
  bool _esContrasena6Caracteres = false;

  //!Controlador de Texto
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController confContrasenaController = TextEditingController();
  TextEditingController numCelularController = TextEditingController();
  TextEditingController dirCasaController = TextEditingController();

  //!LLave global
  final GlobalKey<FormState> _formKey = GlobalKey();

  laContrasenaCambiada(String contra) {
    setState(() {
      if (contra.length >= 6) {
        _esContrasena6Caracteres = true;
      } else {
        _esContrasena6Caracteres = false;
      }

      if (contra.isEmpty) {
        _formKey.currentState?.validate();
      } else {
        contra.isNotEmpty;
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final _registerCubitState = BlocProvider.of<RegisterCubit>(context);

    return Scaffold(
      //*Arriba
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Color.fromARGB(255, 102, 0, 255),
        title: Text(
          "Registro",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      //*Medio
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
         
          // TODO: implement listener
          if (state is RegisterFailed) {
            // ignore: avoid_print
            print("Hay un Error: ${state.errorView.toString()}" );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorView.toString()),
                duration: Duration(seconds: 4),
              ),

            );
            
          }

          if (state is RegisterSuccessfull) {
            // ignore: avoid_print
            print("Usuario Registrado: ${state.toString()}" ); 
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registrado con Exito"),
                duration: Duration(seconds: 4),
              ),
            );
            
            Navigator.pushReplacementNamed(context, 'home_view');
          }
            
        },

        builder: (context, state) {
          
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextFormField(
                      controller: nombreController,
                      textCapitalization: TextCapitalization.words,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nombre",
                          hintText: "Ingresar Nombre"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Llene la casilla";
                        } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return "Ingrese un Nombre correcto.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },

                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: apellidoController,
                      textCapitalization: TextCapitalization.words,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Apellido",
                          hintText: "Ingresar Apellido"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Llene la casilla";
                        } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return "Ingrese un Apellido correcto.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                    ),
                    
                    SizedBox(height: 20),
                    
                    TextFormField(
                      controller: correoController,
                      enableInteractiveSelection: true,
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
                          return "Ingrese un Correo Electronico correcto.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                    ),
                    
                    SizedBox(height: 20),
                    
                    TextFormField(
                      onChanged: (contra) => laContrasenaCambiada(contra),
                      controller: contrasenaController,
                      obscureText: !_esVisible,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Contraseña",
                        hintText: "Ingresar Contraseña",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState( () {
                              _esVisible = !_esVisible;
                            });
                          },
                          icon: _esVisible
                              ? Icon(Icons.visibility, color: Colors.black87)
                              : Icon(Icons.visibility_off, color: Colors.grey),
                        ),
                      ),
                      
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Llene la casilla";
                        }
                      },
                    ),

                    SizedBox(height: 10),
                    
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: _esContrasena6Caracteres
                                ? Colors.green[700]
                                : Colors.transparent,
                            border: _esContrasena6Caracteres
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
                        SizedBox(width: 10),
                        Text("Debe contener al menos 6 caracteres"),
                      ],
                    ),

                    /* //todo: NO BORRAR, linea de codigo para verificar si la contraseña es "fuerte"  
                SizedBox(height: 15),
    
                LinearProgressIndicator(
                  value: 1/4,
                  backgroundColor: Colors.grey[300],
                  color: Colors.red[600],
                ),
    
                SizedBox(height: 10),
                
                Text("datos"),
              */

                    SizedBox(height: 20),
                    TextFormField(
                      controller: numCelularController,
                      keyboardType: TextInputType.phone,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixText: "+56 9 ",
                        labelText: "Numero de Celular",
                      ),
                      
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "LLene la Casilla";
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "Ingrese un Numero correcto.";
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: dirCasaController,
                      textCapitalization: TextCapitalization.sentences,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Direccion de su Casa",
                          hintText: "Opcional"),
                      validator: (String? value) {
                        if (value!.isNotEmpty &&
                            !RegExp(r'^[a-z A-Z 0-9 , .]+$').hasMatch(value)) {
                          return "Ingrese una Direccion correcta.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      child: FilledButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(255, 102, 0, 255);
                              }
                              return null;
                            },
                          ),
                        ),

                        child: Text("Registrarse"),

                        //?Funcion al Apretar el boton tiene que hacer que los datos.......
                        onPressed: () async {
                          String nombre = nombreController.text.trim();
                          String apellido = apellidoController.text.trim();
                          String correo = correoController.text.trim();
                          String contrasena = contrasenaController.text.trim();
                          String numCelular = numCelularController.text.trim();
                          String dirCasa = dirCasaController.text.trim();

                          if (nombre == apellido) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cerrar"),
                                  )
                                ],
                                title: const Text("Error"),
                                contentPadding: const EdgeInsets.all(20),
                                content: const Text(
                                    "El Nombre y Apellido no pueden ser el mismo."),
                              ),
                            );
                          } else if (_formKey.currentState!.validate() && _esContrasena6Caracteres == true) {
                            
                            _registerCubitState.RegisterUser(email: correo, password: contrasena, name: nombre, lastName: apellido, phone: numCelular, address: dirCasa);
                            
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
