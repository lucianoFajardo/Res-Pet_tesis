// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/bloc/register_metadata/register_metadata_cubit.dart';
import 'package:respet_app/src/models/user_data.dart';

class RegisterDataUser extends StatefulWidget {
  const RegisterDataUser({super.key});
  @override
  State<RegisterDataUser> createState() => _RegisterDataUserState();
}

class _RegisterDataUserState extends State<RegisterDataUser> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameUser = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController celphone = TextEditingController();
  TextEditingController location = TextEditingController();

  clearForm() {
    nameUser.clear();
    lastName.clear();
    celphone.clear();
    location.clear();
  }

  @override
  Widget build(BuildContext context) {
    RegisterMetadataCubit registerMetadata =
        context.read<RegisterMetadataCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresa tus datos', style: TextStyle(fontSize: 22)),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<RegisterMetadataCubit, RegisterMetadataState>(
              builder: (_, state) {
                if (state is RegisterErrorMetadataState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.toString()),
                      duration: const Duration(minutes: 10),
                    ),
                  );
                }
                if (state is RegisterLoadingMetadataState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is RegisterUploadMetadataState) {
                  Navigator.pushReplacementNamed(context, 'home_view');
                }
                return Column(
                  children: [
                    TextFormField(
                        controller: nameUser,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nombre",
                            hintText: "Ingresar Nombre"),
                        validator: (value) =>
                            validateField(value, RegExp(r'^[a-z A-Z]+$')),
                        onChanged: (value) => formKey.currentState?.validate()),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: lastName,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Apellido",
                            hintText: "Ingresar Apellido"),
                        validator: (value) =>
                            validateField(value, RegExp(r'^[a-z A-Z]+$')),
                        onChanged: (value) => formKey.currentState?.validate()),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: celphone,
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Telefono",
                            hintText: "Ingresar Telefono"),
                        validator: (value) =>
                            validateField(value, RegExp(r'^[0-9]+$')),
                        onChanged: (value) => formKey.currentState?.validate()),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: location,
                        keyboardType: TextInputType.streetAddress,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Dirección",
                            hintText: "Ingresar Dirección"),
                        validator: (value) => validateField(
                            value, RegExp(r'^[a-z A-Z 0-9 , .]+$')),
                        onChanged: (value) => formKey.currentState?.validate()),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 60,
                        width: 150,
                        child: MaterialButton(
                          height: 50,
                          color: Colors.amber,
                          onPressed: () {
                            final idUser = client.auth.currentSession!.user.id;
                            final obj = registerMetadata.insertData(
                                userMetaData(
                                    name: nameUser.text.trim(),
                                    lastName: lastName.text.trim(),
                                    celphoneNumber: celphone.text.trim(),
                                    idUser: idUser,
                                    locationUser: location.text.trim()));
                            clearForm();
                          },
                          child: Text("Guardar datos"),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

validateField(value, RegExp regExp) {
  if (value!.isEmpty) {
    return "Rellene la casilla";
  } else if (!regExp.hasMatch(value)) {
    return "Ingrese un Formato correcto";
  } else {
    return null;
  }
}


