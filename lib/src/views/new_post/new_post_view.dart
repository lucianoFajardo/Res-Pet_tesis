import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:respet_app/main.dart';
import 'package:respet_app/src/views/example/example_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {

  File ? _imagenSeleccionada;
  bool _botonActivado = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar: AppBar(
          foregroundColor: Colors.deepPurple[600],
          backgroundColor: Colors.grey[300],
          title: const Text("Nueva Publicacion"),

          //*Boton
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11), 
              child: ElevatedButton(
                onPressed: _botonActivado
                ? () async {
                  try {
                    final imagenTipo = _imagenSeleccionada?.path.split(".").last.toLowerCase();
                    final imagenBytes = await _imagenSeleccionada?.readAsBytes();
                    final usuarioID = client.auth.currentUser!.id;
                    final imagenPath = "/$usuarioID/imagen";
                    print(imagenTipo!.characters);
                   // await client.storage.createBucket('img');

                     await client.storage.from("imagenes").uploadBinary(imagenPath, imagenBytes!, fileOptions: FileOptions(upsert: true, contentType: "imagen/$imagenTipo"));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Imagen subida"),
                        duration: Duration(seconds: 4),
                      ),
                    );

                    String imagenUrl = client.storage.from("imagenes").getPublicUrl(imagenPath);
                      imagenUrl = Uri.parse(imagenUrl).replace(queryParameters: {"t": DateTime.now().millisecondsSinceEpoch.toString()}).toString();
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExampleView(imagenURL: imagenUrl)));
                    
                  } catch (e) {
                    print("Tipo de Error: $e");

                  }

                }
                : null,

                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                ), 
                
                child: const Text(" Publicar "),
              ),
            ),
          ],
        ),

        //*Medio
        body: SingleChildScrollView(
          child:  Column(
          children: <Widget>[

            const Divider(height: 5),
        
            _imagenSeleccionada != null 
              ? Stack(
                children: <Widget>[
                  Card(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.blueGrey[100],
                    child: InkWell(
                      splashColor: Colors.purple,

                      onTap: (){
                        seleccionarImagenDeGaleria();
                      },
                      
                      child: SizedBox(
                        height: 300,
                        width: 370,

                        child: Image.file(_imagenSeleccionada!, fit: BoxFit.fill, filterQuality: FilterQuality.low)
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 6,
                    right: 8,
                    child: SizedBox(
                      child: IconButton(
                        color: const Color.fromARGB(255, 209, 13, 13),
                        splashColor: const Color.fromARGB(255, 255, 41, 41),

                        iconSize: 30,
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: (){
                          setState(() {
                            _imagenSeleccionada = null;
                            _botonActivado = false;
                          });
                        }
                      ),
                    )
                  ),
                ],
              )
              : Card(
                clipBehavior: Clip.hardEdge,
                color: Colors.blueGrey[100],
                child: InkWell(
                  splashColor: Colors.purple,
                      
                  onTap: (){
                    seleccionarImagenDeGaleria();
                    
                  },

                  child: const SizedBox(
                    height: 300,
                     width: 370,
                    child: Center(
                      child: Text("Seleccione una Imagen de su Galeria."),
                    ),
                  ),
                ),  
              ),

            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500]),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Pie de Foto"
                ),
              ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Nombre"
                ),
              ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Color del Pelaje"
                ),
              ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Peso en Kilos"
                ),
              ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Edad"
                ),
              ),
              ),
            ),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Sexo"
                ),
              ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "Agregar Ubicacion", 
                  textAlign: TextAlign.left, 
                  style: TextStyle(color: Colors.deepPurple[600], fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            const SizedBox(height: 8),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 30,
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (){}, 
                      
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor: Colors.white60,
                        foregroundColor: Colors.black87,
                        shadowColor: Colors.black,
                      ),
                      child: const Text(" Iquique "),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: (){}, 
                        
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                          backgroundColor: Colors.white60,
                          foregroundColor: Colors.black87,
                          shadowColor: Colors.black,
                        ),
                        child: const Text(" Alto Hospicio "),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: (){}, 
                        
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                          backgroundColor: Colors.white60,
                          foregroundColor: Colors.black87,
                          shadowColor: Colors.black,
                        ),
                        child: const Text(" ... "),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 40,
              ),

              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Vacunas", 
                        style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold), 
                      ),
                    ),

                    const SizedBox(width: 250),

                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: (){},

              ),
            ),

            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),

              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Chip", 
                        style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold), 
                      ),
                    ),
                    const SizedBox(width: 280),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: (){},

              ),
            ),
            
            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),

              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Estirilización", 
                        style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold), 
                      ),
                    ),

                    const SizedBox(width: 230),

                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: (){},

              ),
            ),
            
            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),

              child: TextButton(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tamaño", 
                        style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold), 
                      ),
                    ),

                    const SizedBox(width: 270),

                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.deepPurple[600]),
                  ],
                ),
                onPressed: (){},

              ),
            ),
            
            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              
              child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.phone),
                  hintText: "+56 9 ",
                ),
              ),
              ),
            ),

            Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: [
                    Align (
                      alignment: Alignment.topLeft,
                      child: Text("Cuidados Específicos", style: TextStyle(color: Colors.deepPurple[600], fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                    
                    const TextField(
                      maxLines: null,
                      textAlign: TextAlign.left, 
                      decoration: InputDecoration(
                        hintText: "Escriba aqui.",
                      ),

                    ),
                  ],
                  
                )
              ),
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future seleccionarImagenDeGaleria() async {
    final _imagenIngresada = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imagenSeleccionada = File(_imagenIngresada!.path);
      _botonActivado = true;
    });
  }
}