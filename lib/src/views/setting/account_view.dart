import 'package:flutter/material.dart';

class ViewAccount extends StatelessWidget {
  const ViewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis datos'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios, //flecha de regreso //
              color: Colors.black,
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [

              // AQUI crear un boton que si el usuario no tiene data registrada el pueda ingresar su data,
              // Si el usuario ya tiene data mostrar su data SI NO mostrar el boton para que pueda registrar su data
              
              Text('Nombre:'),
              Text('Ape'),
              Text('telefono'),
              //TODO : Aqui el usuario debe poder editar sus datos , como , nombre, ape, edad
            ],
          ),
        ));
  }
}
