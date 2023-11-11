// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:respet_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPostView extends StatefulWidget {
  const EditPostView({super.key});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {

  @override
  void initState() {
    super.initState();
    traerImagen();
  }

  final supabase = Supabase.instance.client;
  String imagenURL = "";

  File? _imagenSeleccionada;
  bool _hayImagen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //*Arriba BOTON
      appBar: AppBar(
          title: const Text("edit post"),

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11), 
              child: ElevatedButton(
                onPressed: () async{
                  
                  try{
                    
                    
                    final imagenTipo = _imagenSeleccionada?.path.split(".").last.toLowerCase();
                    final imagenBytes = await _imagenSeleccionada?.readAsBytes();
                    final usuarioID = client.auth.currentUser!.id;
                    //String fechaHora = DateTime.now().toIso8601String();

                    final imagenSupabase = await supabase.from("created_post_adoption_pet").select("photo_pet");
                    String imagenPathOriginal = imagenSupabase.toString().substring(126, imagenSupabase.toString().length - 2);

                    final imagenPath = "/$usuarioID/$imagenPathOriginal";
                      
                    String imagenUrl = client.storage.from("imagenes").getPublicUrl(imagenPath);
                    
                    //  imagenUrl = Uri.parse(imagenUrl).replace(queryParameters: {"t": DateTime.now().millisecondsSinceEpoch.toString()}).toString();
                    
                    
                    await supabase.storage
                      .from("imagenes")
                      .updateBinary(imagenPath, imagenBytes!, fileOptions: FileOptions(contentType: "imagen/$imagenTipo"));
                    
                    /*
                    await supabase
                      .from("created_post_adoption_pet")
                      .update({"photo_pet": imagenUrl})
                      .match({"id_user_created": usuarioID});
                    */

                   
                    print("Exito");
                    
                  }catch (error){

                    print("Error: $error");

                  }
                },
                
                child: const Text("Modificar")
              )

            ),
          ],  
      ),

      //*Medio
      body: imagenURL.isEmpty
      ? const Center(child: CircularProgressIndicator(),) 

      : _hayImagen == false

      ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
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
              child: Image.network(imagenURL, fit: BoxFit.fill, filterQuality: FilterQuality.low)
            ),
          ),
        ),
      )

      : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
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
      )
    );
  }

  Future traerImagen() async {
    final imagenSupabase = await supabase.from("created_post_adoption_pet").select("photo_pet");

    setState(() {
      imagenURL = imagenSupabase.toString().substring(13, imagenSupabase.toString().length - 2);
      print(imagenURL);

    });
  }

  Future seleccionarImagenDeGaleria() async {
    final _imagenIngresada = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imagenSeleccionada = File(_imagenIngresada!.path);

      if(_imagenSeleccionada.toString().isNotEmpty){
        _hayImagen = true;
      }
    });
  }
}