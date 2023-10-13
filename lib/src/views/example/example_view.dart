import 'package:flutter/material.dart';
import 'package:respet_app/main.dart';

class ExampleView extends StatelessWidget {
  ExampleView({super.key, required this.imagenURL});

  final usuarioID = client.auth.currentUser!.id;

  final String? imagenURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejemplo"),
      ),

      body: Center(
        child: Card(
          child: SizedBox(
            height: 200,
            width: 200,
            child: imagenURL != null
              ? Image.network(imagenURL!, fit: BoxFit.cover)

              : const Center(
                child: Text("Nada"),
              )
          ),
        ),
      ),
    );
  }
}