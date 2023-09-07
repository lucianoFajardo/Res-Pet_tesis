// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}
class _RegisterViewState extends State<RegisterView> {
  //String? nombre;
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre",
                      hintText: "Ingresar Nombre"),
                ),
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Apellido",
                      hintText: "Ingresar Apellido"),
                ),
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo Electronico",
                      hintText: "Ingresar Correo Electronico"),
                ),
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña",
                      hintText: "Ingresar Contraseña"),
                ),
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmar Contraseña",
                      hintText: "Ingrese nuevamente Contraseña"),
                ),
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixText: "+56 9 ",
                    labelText: "Numero de Celular",
                    suffixIcon: Icon(Icons.flag_circle),
                  ),
                ),
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Direccion de Casa",
                      hintText: "Opcional"),
                ),
              ),
              Divider(
                height: 30,
              ),
              SizedBox(
                child: FilledButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
