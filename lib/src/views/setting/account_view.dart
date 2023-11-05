import 'package:flutter/material.dart';

class ViewAccount extends StatelessWidget {
  const ViewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('View Account')),
        body:const Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Nombre:'),
              Text('Ape'),
              Text('telefono'),
              //TODO : Aqui el usuario debe poder editar sus datos , como , nombre, ape, edad
            ],
          ),
        ));
  }
}
