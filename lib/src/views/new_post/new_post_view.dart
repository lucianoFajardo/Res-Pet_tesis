import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/bloc/new_post/new_post_cubit.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  //!Controladores de Texto
  TextEditingController pieFotoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController colorPelajeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController vacunaController = TextEditingController();
  TextEditingController tamanoController = TextEditingController();
  TextEditingController cuidadoController = TextEditingController();

  //!LLave global
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<String> itemsEstirilizado = ["Si", "No"];
  String? selectedItemEstirilizado;

  List<String> itemsLocalidad = ["Iquique", "Alto Hospicio"];
  String? selectedItemLocalidad;

  List<String> itemsSexo = ["Macho", "Hembra"];
  String? selectedItemSexo;

  File? _imagenSeleccionada;
  bool _hayImagen = false;

  bool? esterilizado;

  @override
  Widget build(BuildContext context) {
    final newPostCubitState = BlocProvider.of<NewPostCubit>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Nueva Publicacion"),
          //*Boton
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
              child: ElevatedButton(
                onPressed: _hayImagen && _formKey.currentState!.validate()
                    ? () async {
                        try {
                          final imagenTipo = _imagenSeleccionada?.path
                              .split(".")
                              .last
                              .toLowerCase();
                          final imagenBytes =
                              await _imagenSeleccionada?.readAsBytes();
                          final usuarioID = client.auth.currentUser!.id;
                          String fechaHora = DateTime.now().toIso8601String();
                          final imagenPath = "/$usuarioID/imagen$fechaHora";
                          String imagenUrl = client.storage
                              .from("imagenes")
                              .getPublicUrl(imagenPath);
                          imagenUrl = Uri.parse(imagenUrl)
                              .replace(queryParameters: {
                            "t":
                                DateTime.now().millisecondsSinceEpoch.toString()
                          }).toString();
                          String nombreMascota = nombreController.text.trim();
                          String descripcion = pieFotoController.text.trim();
                          String colorPelaje =
                              colorPelajeController.text.trim();
                          //
                          String peso = pesoController.text.trim();
                          double pesoFloat = double.parse(peso);
                          //
                          String edad = edadController.text.trim();
                          int? edadInt = int.tryParse(edad);
                          //
                          String tamano = tamanoController.text.trim();
                          int? tamanoInt = int.tryParse(tamano);
                          //
                          String cuidadoEspecial =
                              cuidadoController.text.trim();
                          setState(() {
                            if (selectedItemEstirilizado == "Si") {
                              esterilizado = true;
                            } else {
                              esterilizado = false;
                            }
                          });
                          newPostCubitState.NewPostUpload(
                              fotoMascota: imagenUrl,
                              nombreMascota: nombreMascota,
                              descripcionMascota: descripcion,
                              colorPelaje: colorPelaje,
                              pesoMascota: pesoFloat,
                              edadMascota: edadInt!,
                              generoMascota: selectedItemSexo!,
                              localidadMascota: selectedItemLocalidad!,
                              esterilizadoMascota: esterilizado!,
                              tamanoMascota: tamanoInt!,
                              cuidadoMascota: cuidadoEspecial,
                              imagenPath: imagenPath,
                              imagenBytes: imagenBytes,
                              imagenTipo: imagenTipo);
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
        body: BlocConsumer<NewPostCubit, NewPostState>(
            listener: (context, state) {
          // TODO: implement listener
          if (state is NewPostFailed) {
            // ignore: avoid_print
            print("Hay un Error: ${state.errorView.toString()}");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorView.toString()),
                duration: const Duration(seconds: 4),
              ),
            );
          }

          if (state is NewPostSuccessful) {
            // ignore: avoid_print
            print("Nuevo Post: ${state.toString()}");

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Post agregado con Exito"),
                duration: Duration(seconds: 4),
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
                  const Divider(height: 5),
                  _imagenSeleccionada != null
                      ? Stack(
                          children: <Widget>[
                            Card(
                              clipBehavior: Clip.hardEdge,
                              color: Colors.blueGrey[100],
                              child: InkWell(
                                splashColor: Colors.purple,
                                onTap: () {
                                  seleccionarImagenDeGaleria();
                                },
                                child: SizedBox(
                                    height: 300,
                                    width: 370,
                                    child: Image.file(_imagenSeleccionada!,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.low)),
                              ),
                            ),
                            Positioned(
                                bottom: 6,
                                right: 8,
                                child: SizedBox(
                                  child: IconButton(
                                      color: const Color.fromARGB(
                                          255, 209, 13, 13),
                                      splashColor: const Color.fromARGB(
                                          255, 255, 41, 41),
                                      iconSize: 30,
                                      icon: const Icon(Icons.cancel_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _imagenSeleccionada = null;
                                          _hayImagen = false;
                                        });
                                      }),
                                )),
                          ],
                        )
                      : Card(
                          clipBehavior: Clip.hardEdge,
                          color: Colors.blueGrey[100],
                          child: InkWell(
                            splashColor: Colors.purple,
                            onTap: () {
                              seleccionarImagenDeGaleria();
                            },
                            child: const SizedBox(
                              height: 300,
                              width: 370,
                              child: Center(
                                child: Text(
                                    "Seleccione una Imagen de su Galeria."),
                              ),
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
                            hintText: "Pie de Foto"),
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
                  const SizedBox(height: 10),
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
                            border: UnderlineInputBorder(),
                            hintText: "Vacunas"),
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
        }));
  }

  Future seleccionarImagenDeGaleria() async {
    final _imagenIngresada =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imagenSeleccionada = File(_imagenIngresada!.path);
      _hayImagen = true;
    });
  }
}
