// ignore_for_file: avoid_print
import 'dart:io';
import 'package:respet_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:respet_app/src/models/data_pet.dart';
import 'package:respet_app/src/bloc/edit_post/edit_post_cubit.dart';

class EditPostView extends StatefulWidget {
  const EditPostView({super.key, required this.dataPetGetEdit});
  @override
  State<EditPostView> createState() => _EditPostViewState();
  final data_pet dataPetGetEdit;
}

class _EditPostViewState extends State<EditPostView> {

  //?Traer los Datos
  @override
  void initState() {
    super.initState();

    imagenURL = widget.dataPetGetEdit.id_photo_pet;
    pieFotoController.text = widget.dataPetGetEdit.description_pet;
    nombreController.text = widget.dataPetGetEdit.name_pet;
    colorPelajeController.text = widget.dataPetGetEdit.fur_color;
    pesoController.text = widget.dataPetGetEdit.weight_pet.toString();
    edadController.text = widget.dataPetGetEdit.age_pet.toString();
    selectedItemSexo = widget.dataPetGetEdit.gender_pet;
    selectedItemLocalidad = widget.dataPetGetEdit.location;
    
    if(widget.dataPetGetEdit.is_sterilization){
      selectedItemEstirilizado = "Si";
    }else{
      selectedItemEstirilizado = "No";
    }

    vacunaController.text = widget.dataPetGetEdit.vaccines_pet;
    tamanoController.text = widget.dataPetGetEdit.size_pet.toString();
    cuidadoController.text = widget.dataPetGetEdit.specific_care;
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
  bool? esterilizado;

  @override
  Widget build(BuildContext context) {
    final editPostCubitState = BlocProvider.of<EditPostCubit>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Editar publicaciones"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios, //*flecha de regreso
              color: Colors.black,
            ),
          ),
          
          //*BOTON MODIFICAR
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
                child: ElevatedButton(
                    onPressed: () async{
                      try {

                        final imagenTipo = _imagenSeleccionada?.path.split(".").last.toLowerCase();
                        final imagenBytes = await _imagenSeleccionada?.readAsBytes();
                        final usuarioID = client.auth.currentUser!.id;
                        
                        String nombreMascota = nombreController.text.trim();
                        String descripcion = pieFotoController.text.trim();
                        String colorPelaje = colorPelajeController.text.trim();
                        String cuidadoEspecial = cuidadoController.text.trim();
                        String vacunas = vacunaController.text.trim();
                        String mascotaID = widget.dataPetGetEdit.id_pet;

                        String peso = pesoController.text.trim();
                        double pesoFloat = double.parse(peso);

                        String edad = edadController.text.trim();
                        int? edadInt = int.tryParse(edad);

                        String tamano = tamanoController.text.trim();
                        int? tamanoInt = int.tryParse(tamano);
                        
                        String tiempoAhora = DateTime.now().toString();

                        setState(() {
                          if (selectedItemEstirilizado == "Si") {
                            esterilizado = true;
                          } else {
                            esterilizado = false;
                          }
                        });

                        editPostCubitState.EditPostUpdate(
                          fotoMascota: imagenURL, nombreMascota: nombreMascota, descripcionMascota: descripcion,
                          colorPelaje: colorPelaje, pesoMascota: pesoFloat, edadMascota: edadInt!,
                          generoMascota: selectedItemSexo!, localidadMascota: selectedItemLocalidad!, 
                          esterilizadoMascota: esterilizado!, tamanoMascota: tamanoInt!, 
                          cuidadoMascota: cuidadoEspecial, vacunasMascota: vacunas,
                          imagenBytes: imagenBytes, imagenTipo: imagenTipo, 
                          mascotaID: mascotaID, usuarioID: usuarioID, hayImagen: _hayImagen, tiempoAhora: tiempoAhora);
                        
                      } catch (error) {
                        print("Error: $error");
                      }
                    },
                    
                  child: const Text("Modificar")
                )
              ),
          ],
        ),

        //*Medio
        body: BlocConsumer<EditPostCubit, EditPostState>(
          listener: (context, state) {

            if(state is EditPostFailed){
              print("Hay un Error: ${state.errorView.toString()}");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorView.toString()),
                  duration: const Duration(seconds: 6),
                ),
              );
            }

            if(state is EditPostSuccessful){
              print("Post Editado: ${state.toString()}");

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Post Modificado con Exito"),
                  duration: Duration(seconds: 6),
                ),
              );

              Navigator.pushReplacementNamed(context, 'home_view');
            }

          }, builder: (context, state) {
            return Form(
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
          ); 
        },
      )  
    );
  }

  Future selectImageGalery() async {
    final imagenIngresada = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imagenSeleccionada = File(imagenIngresada!.path);
      if (_imagenSeleccionada.toString().isNotEmpty) {
        _hayImagen = true;
      }
    });
  }
}
