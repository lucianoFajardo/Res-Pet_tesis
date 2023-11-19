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

  //?Ejecutar Funciones
  @override
  void initState() {
    super.initState();
    traerImagen();
    traerInformacion();
  }

  //!LLave global
  final GlobalKey<FormState> _formKey = GlobalKey();

  //!Controladores de Texto
  TextEditingController pieFotoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController colorPelajeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController vacunaController = TextEditingController();
  TextEditingController tamanoController = TextEditingController();
  TextEditingController cuidadoController = TextEditingController();  

  final supabase = Supabase.instance.client;
  String imagenURL = "";
  File? _imagenSeleccionada;
  bool _hayImagen = false;

  List<String> itemsSexo = ["Macho", "Hembra"];
  String? selectedItemSexo;

  List<String> itemsLocalidad = ["Iquique", "Alto Hospicio"];
  String? selectedItemLocalidad;

  List<String> itemsEstirilizado = ["Si", "No"];
  String? selectedItemEstirilizado;

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
                    /*
                    final imagenTipo = _imagenSeleccionada?.path.split(".").last.toLowerCase();
                    final imagenBytes = await _imagenSeleccionada?.readAsBytes();
                    final usuarioID = client.auth.currentUser!.id;

                    final imagenSupabase = await supabase.from("created_post_adoption_pet").select("photo_pet");
                    String imagenPathOriginal = imagenSupabase.toString().substring(126, imagenSupabase.toString().length - 2);

                    final imagenPath = "/$usuarioID/$imagenPathOriginal";
                      
                    String imagenUrl = client.storage.from("imagenes").getPublicUrl(imagenPath);
                     
                    await supabase.storage
                      .from("imagenes")
                      .updateBinary(imagenPath, imagenBytes!, fileOptions: FileOptions(contentType: "imagen/$imagenTipo"));
                    
                    await supabase
                      .from("created_post_adoption_pet")
                      .update({"photo_pet": imagenUrl})
                      .match({"id_user_created": usuarioID});
                      
                    print("Exito");
                    */
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              imagenURL.isEmpty
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
              ),

              Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500]),
              
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                    
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: pieFotoController,
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: true,
                    maxLength: 200,
                    decoration:  const InputDecoration(
                      border: UnderlineInputBorder(),
                       hintText: "Descripcion",
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[a-z A-Z0-9_.-]+$').hasMatch(value)) {
                        return "No ocupe signos ni simbolos";
                      } else {
                        return null;
                      }
                    },

                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
            
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                    
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: nombreController,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 10,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Nombre"
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "No ocupe signos, simbolos y numeros";
                      } else {
                        return null;
                      }
                    },

                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },

                  ),
                ),
              ),
              
              const SizedBox(height: 10),
            
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: colorPelajeController,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 8,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Color del Pelaje"
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "No ocupe signos, simbolos y numeros";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                  ),
                ),
              ),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: pesoController,
                    maxLength: 2,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Peso en Kilos"
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                        return "Ocupe solamente numeros.";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),
            
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: edadController,
                    maxLength: 2,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Edad"
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                        return "Ocupe solamente numeros.";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),
            
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 40,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sexo",
                          style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
        
                      const SizedBox(width: 30),
        
                      DropdownButton<String>(
                        value: selectedItemSexo,
                        items: itemsSexo.map((e) => DropdownMenuItem<String>(
                          value: e, child: Text(e, style: const TextStyle(fontSize: 15),))).toList(),
                      
                        onChanged: (e) => setState(() => selectedItemSexo = e)
                      ),
                    ],
                  )
                ),
              ),

              Divider(height: 30, indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500]),
            
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 40,
                ),
        
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Localidad",
                          style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
        
                      const SizedBox(width: 30),
        
                      DropdownButton<String>(
                        value: selectedItemLocalidad,
                        items: itemsLocalidad.map((e) => DropdownMenuItem<String>(
                          value: e, child: Text(e, style: const TextStyle(fontSize: 15),))).toList(),
                      
                        onChanged: (e) => setState(() => selectedItemLocalidad = e)
                      ),
                    ],
                  )
                ),
              ),

              Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 30),
            
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 40,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Estirilizado",
                          style: TextStyle(color: Colors.deepPurple[600], fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
        
                      const SizedBox(width: 40),
        
                      DropdownButton<String>(
                        value: selectedItemEstirilizado,
                        items: itemsEstirilizado.map((e) => DropdownMenuItem<String>(
                          value: e, child: Text(e, style: const TextStyle(fontSize: 15),))).toList(),
                      
                        onChanged: (e) => setState(() => selectedItemEstirilizado = e),
                      ),
                    ],
                  )
                ),
              ),

              Divider(indent: 5, endIndent: 5,thickness: 1, color: Colors.grey[500], height: 25),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: vacunaController,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 150,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Vacunas"
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[a-zA-Z0-9_.-]*$').hasMatch(value)) {
                        return "No ocupe signos ni simbolos";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },

                  ),
                ),
              ),

              const SizedBox(height: 10),
                  
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TextFormField(
                    controller: tamanoController,
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.words,
                    maxLines: 1,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Tamaño en centimetros",
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Llene la casilla";
                      } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                        return "Ocupe solamente numeros.";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),
            
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

                      TextFormField(
                        controller: cuidadoController,
                        textAlign: TextAlign.left,
                        maxLength: 200,
                        decoration: const InputDecoration(
                          hintText: "Escriba aqui.",
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Llene la casilla";
                          } else if (!RegExp(r'^[a-zA-Z0-9_.-]+$').hasMatch(value)) {
                            return "No ocupe signos ni simbolos";
                          } else {
                            return null;
                          }
                        },
                        
                        onChanged: (value) {
                          _formKey.currentState?.validate();
                        },
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 10),

            ],
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

  Future traerInformacion() async{
    try{
      final infoSupDes = await supabase.from("created_post_adoption_pet").select("description_pet");
      final infoSupNam = await supabase.from("created_post_adoption_pet").select("name_pet");
      final infoSupCol = await supabase.from("created_post_adoption_pet").select("fur_color");
      final infoSupPes = await supabase.from("created_post_adoption_pet").select("weight_pet");
      final infoSupEda = await supabase.from("created_post_adoption_pet").select("age_pet");
      final infoSupSex = await supabase.from("created_post_adoption_pet").select("gender_pet");
      final infoSupLoc = await supabase.from("created_post_adoption_pet").select("location"); 
      final infoSupEst = await supabase.from("created_post_adoption_pet").select("is_sterilization");
      final infoSupVac = await supabase.from("created_post_adoption_pet").select("vaccines_pet");
      final infoSupTam = await supabase.from("created_post_adoption_pet").select("size_pet");
      final infoSupCui = await supabase.from("created_post_adoption_pet").select("specific_care");

      setState(() {

        final infoPetDes = infoSupDes.toString().substring(19, infoSupDes.toString().length - 2);
        pieFotoController.text = infoPetDes;
        
        final infoPetName = infoSupNam.toString().substring(12, infoSupNam.toString().length - 2);
        nombreController.text = infoPetName;

        final infoPetCol = infoSupCol.toString().substring(13, infoSupCol.toString().length - 2);
        colorPelajeController.text = infoPetCol;

        final infoPetPes = infoSupPes.toString().substring(14, infoSupPes.toString().length - 2);
        pesoController.text = infoPetPes;

        final infoPetEda = infoSupEda.toString().substring(11, infoSupEda.toString().length - 2);
        edadController.text = infoPetEda;

        final infoPetSex = infoSupSex.toString().substring(14, infoSupSex.toString().length - 2);
        selectedItemSexo = infoPetSex;
        
        final infoPetLoc = infoSupLoc.toString().substring(12, infoSupLoc.toString().length - 2);
        selectedItemLocalidad = infoPetLoc;

        final infoPetEst = infoSupEst.toString().substring(20, infoSupEst.toString().length - 2);
        if(infoPetEst == "true"){
          selectedItemEstirilizado = "Si";
        }else{
          selectedItemEstirilizado = "No";
        }

        final infoPetVac = infoSupVac.toString().substring(16, infoSupVac.toString().length - 2);
        vacunaController.text = infoPetVac;
        
        final infoPetTam = infoSupTam.toString().substring(12, infoSupTam.toString().length - 2);
        tamanoController.text = infoPetTam;

        final infoPetCui = infoSupCui.toString().substring(17, infoSupCui.toString().length - 2);
        cuidadoController.text = infoPetCui;

      });

    }catch (e){

      print("Error: $e");
    }

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