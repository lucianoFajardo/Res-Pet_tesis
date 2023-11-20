// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:respet_app/src/models/data_pet.dart';

class EditPostView extends StatefulWidget {
  const EditPostView({super.key, required this.dataPetGetEdit});

  
  @override
  State<EditPostView> createState() => _EditPostViewState();

  final data_pet
      dataPetGetEdit; //TODO -> este campo ya trae la data del perro que se selecciono
      //! bastian tu implementa el cubit y cuando lo hagas me avisas asi vemos de reducir el codigo
}

class _EditPostViewState extends State<EditPostView> {

  //?Ejecutar Funciones
  @override
  void initState() {
    super.initState();
    print(widget.dataPetGetEdit.name_pet + widget.dataPetGetEdit.age_pet.toString()); //TODO -> este es un ejemplo para que veas que la data ya esta cargada si seleccionas cualquier post vas a poder modificar ese post unicamente
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
          title: const Text("Editar publicaciones"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios, //flecha de regreso //
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
                child: ElevatedButton(
                    onPressed: () {

                      print(widget.dataPetGetEdit.name_pet);  // TODO -> este es un ejemplo pero la data que yo voy a modificar ya esta enviada por indice
                      try {
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
                      } catch (error) {
                        print("Error: $error");
                      }
                    },
                    child: const Text("Modificar"))),
          ],
        ),

        //*Medio
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                imagenURL.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _hayImagen == false
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              color: Colors.blueGrey[100],
                              child: InkWell(
                                splashColor: Colors.purple,
                                onTap: () {
                                  selectImageGalery();
                                },
                                child: SizedBox(
                                    height: 300,
                                    width: 370,
                                    child: Image.network(imagenURL,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.low)),
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
                                onTap: () {
                                  selectImageGalery();
                                },
                                child: SizedBox(
                                    height: 300,
                                    width: 370,
                                    child: Image.file(_imagenSeleccionada!,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.low)),
                              ),
                            ),
                          ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                    color: Colors.grey[500]),
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
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Descripcion",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Llene la casilla";
                        } else if (!RegExp(r'^[a-z A-Z0-9_.-]+$')
                            .hasMatch(value)) {
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
                          border: UnderlineInputBorder(), hintText: "Nombre"),
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
                          hintText: "Color del Pelaje"),
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
                          hintText: "Peso en Kilos"),
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
                          border: UnderlineInputBorder(), hintText: "Edad"),
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
                              style: TextStyle(
                                  color: Colors.deepPurple[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 30),
                          DropdownButton<String>(
                              value: selectedItemSexo,
                              items: itemsSexo
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(fontSize: 15),
                                      )))
                                  .toList(),
                              onChanged: (e) =>
                                  setState(() => selectedItemSexo = e)),
                        ],
                      )),
                ),
                Divider(
                    height: 30,
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                    color: Colors.grey[500]),
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
                              style: TextStyle(
                                  color: Colors.deepPurple[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 30),
                          DropdownButton<String>(
                              value: selectedItemLocalidad,
                              items: itemsLocalidad
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(fontSize: 15),
                                      )))
                                  .toList(),
                              onChanged: (e) =>
                                  setState(() => selectedItemLocalidad = e)),
                        ],
                      )),
                ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                    color: Colors.grey[500],
                    height: 30),
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
                              style: TextStyle(
                                  color: Colors.deepPurple[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 40),
                          DropdownButton<String>(
                            value: selectedItemEstirilizado,
                            items: itemsEstirilizado
                                .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 15),
                                    )))
                                .toList(),
                            onChanged: (e) =>
                                setState(() => selectedItemEstirilizado = e),
                          ),
                        ],
                      )),
                ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                    color: Colors.grey[500],
                    height: 25),
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
                          border: UnderlineInputBorder(), hintText: "Vacunas"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Llene la casilla";
                        } else if (!RegExp(r'^[a-z A-Z0-9_.-]*$')
                            .hasMatch(value)) {
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Cuidados Específicos",
                              style: TextStyle(
                                  color: Colors.deepPurple[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
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
                              } else if (!RegExp(r'^[a-z A-Z0-9_.-]+$')
                                  .hasMatch(value)) {
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
                      )),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  Future selectImageGalery() async {
    final imagenIngresada =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imagenSeleccionada = File(imagenIngresada!.path);
      if (_imagenSeleccionada.toString().isNotEmpty) {
        _hayImagen = true;
      }
    });
  }
}
