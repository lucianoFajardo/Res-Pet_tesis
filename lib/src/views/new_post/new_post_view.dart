// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers
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
  TextEditingController descripcionFotoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController colorPelajeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController vacunaController = TextEditingController();
  TextEditingController tamanoController = TextEditingController();
  TextEditingController cuidadoController = TextEditingController();

  //!LLave global
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? selectedItemEstirilizado;
  String? selectedItemLocalidad;
  String? selectedItemSexo;

  File? _imagenSeleccionada;
  bool _hayImagen = false;

  bool? esterilizado;

  @override
  void initState() {
    super.initState();
    _hayImagen;
  }

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
          title: const Text("Mascota en Adopcion", style: TextStyle(fontSize: 20),),
          titleSpacing: 0.00,
          backgroundColor: Colors.grey[300],

          //*Boton
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              child: ElevatedButton(
                onPressed: _hayImagen && _formKey.currentState!.validate()
                    ? () async {
                        try {
                          final imagenTipo = _imagenSeleccionada?.path.split(".").last.toLowerCase();
                          final imagenBytes = await _imagenSeleccionada?.readAsBytes();
                          final usuarioID = client.auth.currentUser!.id;
                          String fechaHora = DateTime.now().toIso8601String();
                          final imagenPath = "/$usuarioID/imagen$fechaHora";
                          String imagenUrl = client.storage.from("imagenes").getPublicUrl(imagenPath);

                          String nombreMascota = nombreController.text.trim();
                          String descripcion = descripcionFotoController.text.trim();
                          String colorPelaje = colorPelajeController.text.trim();
                          String cuidadoEspecial = cuidadoController.text.trim();
                          String vacunasMascota = vacunaController.text.trim();
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

                          setState(() {
                            if (selectedItemEstirilizado == "Si") {
                              esterilizado = true;
                            } else {
                              esterilizado = false;
                            }
                          });

                          newPostCubitState.NewPostUpload(
                              fotoMascota: imagenUrl, usuarioID: usuarioID,
                              nombreMascota: nombreMascota, descripcionMascota: descripcion, colorPelaje: colorPelaje,
                              pesoMascota: pesoFloat, edadMascota: edadInt!, generoMascota: selectedItemSexo!,
                              localidadMascota: selectedItemLocalidad!, esterilizadoMascota: esterilizado!, 
                              tamanoMascota: tamanoInt!, cuidadoMascota: cuidadoEspecial, imagenPath: imagenPath, 
                              imagenBytes: imagenBytes, imagenTipo: imagenTipo, vacunasMascota: vacunasMascota);
                        
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
            if (state is NewPostFailed) {

              print("Hay un Error: ${state.errorView.toString()}");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorView.toString()),
                  duration: const Duration(seconds: 8),
                ),
              );
            }

            if (state is NewPostSuccessful) {

              print("Nuevo Post: ${state.toString()}");

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Post agregado con Exito"),
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
                  Divider(indent: 5,endIndent: 5,thickness: 1,color: Colors.grey[500]),

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: descripcionFotoController,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: true,
                        maxLength: 200,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Descripcion de la Mascota"),
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
                            border: UnderlineInputBorder(), hintText: "Edad (años)"),
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

                  const SizedBox(height: 8),
                  
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Sexo",
                            style: TextStyle(
                                color: Colors.deepPurple[600],
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                          
                          const SizedBox(width: 30),

                          ConstrainedBox(constraints: const BoxConstraints(
                              maxHeight: 50,
                              maxWidth: 150,
                            
                            ),

                            child: DropdownButtonFormField<String>(
                              items: const[
                                DropdownMenuItem<String>(
                                  value: "Macho",
                                  child: Text("Macho")
                                ),
                                                    
                                DropdownMenuItem<String>(
                                value: "Hembra",
                                child: Text("Hembra")
                                ),
                              ],
                                                  
                              onChanged: (value) async{
                                setState(() {
                                  if(value!.isNotEmpty){
                                    selectedItemSexo = value;
                                    print(selectedItemSexo);
                                  }
                                });
                              },

                              value: selectedItemSexo,
                                
                              validator: ((value) => value == null 
                                ? "Escoge un Sexo" : null),
                                
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            )
                          )
                        ],
                      ),
                    ),

                  Divider(height: 30,indent: 5, endIndent: 5, thickness: 1, color: Colors.grey[500]),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Localidad Encontrada",
                            style: TextStyle(
                                color: Colors.deepPurple[600],
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                          
                          const SizedBox(width: 20),

                          ConstrainedBox(constraints: const BoxConstraints(
                              maxHeight: 60,
                              maxWidth: 150,
                            
                            ),

                            child: DropdownButtonFormField<String>(
                              items: const[
                                DropdownMenuItem<String>(
                                  value: "Iquique",
                                  child: Text("Iquique")
                                ),
                                                    
                                DropdownMenuItem<String>(
                                value: "Alto Hospicio",
                                child: Text("Alto Hospicio")
                                ),
                              ],
                                                  
                              onChanged: (value) async{
                                setState(() {
                                  if(value!.isNotEmpty){
                                    selectedItemLocalidad = value;
                                    print(selectedItemLocalidad);
                                  }
                                });
                              },

                              value: selectedItemLocalidad,
                                
                              validator: ((value) => value == null 
                                ? "Escoge Localidad" : null),
                                                    
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            )
                          )
                        ],
                      ),
                    ),

                  Divider(indent: 5,endIndent: 5,thickness: 1,color: Colors.grey[500],height: 30),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Estirilizado",
                            style: TextStyle(
                                color: Colors.deepPurple[600],
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                          
                          const SizedBox(width: 30),

                          ConstrainedBox(constraints: const BoxConstraints(
                              maxHeight: 50,
                              maxWidth: 150,
                            
                            ),

                            child: DropdownButtonFormField<String>(
                              items: const[
                                DropdownMenuItem<String>(
                                  value: "Si",
                                  child: Text("Si")
                                ),
                                                    
                                DropdownMenuItem<String>(
                                value: "No",
                                child: Text("No")
                                ),
                              ],
                                                  
                              onChanged: (value) async{
                                setState(() {
                                  if(value!.isNotEmpty){
                                    selectedItemEstirilizado = value;
                                    print(selectedItemEstirilizado);
                                  }
                                });
                              },

                              value: selectedItemEstirilizado,
                                
                              validator: ((value) => value == null 
                                ? "Escoge una opcion" : null),
                                
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            )
                          )
                        ],
                      ),
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
                        )
                      ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }));
  }

  Future seleccionarImagenDeGaleria() async {
    final _imagenIngresada = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imagenSeleccionada = File(_imagenIngresada!.path);
      _hayImagen = true;
    });
  }
}
