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
      body: BlocBuilder<RegisterMetadataCubit, RegisterMetadataState>(
        builder: (context, state) {
          if (state is RegisterErrorMetadataState) {
            ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.toString()),
                      duration: const Duration(seconds: 1000),
                    ),
                  );
          }
          if (state is RegisterUploadMetadataState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'home_view');
            });
            print('ingresado');
          }
          if (state is RegisterMetadataInitial) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: nameUser,
                          textCapitalization: TextCapitalization.words,
                          maxLength: 10,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nombre",
                              hintText: "Ingresar Nombre"),
                          validator: (value) =>
                              validateField(value, RegExp(r'^[a-z A-Z]+$')),
                          onChanged: (value) =>
                              formKey.currentState?.validate()),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: lastName,
                          textCapitalization: TextCapitalization.words,
                          maxLength: 12,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Apellido",
                              hintText: "Ingresar Apellido"),
                          validator: (value) =>
                              validateField(value, RegExp(r'^[a-z A-Z]+$')),
                          onChanged: (value) =>
                              formKey.currentState?.validate()),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: celphone,
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Telefono",
                              hintText: "Ingresar Telefono"),

                          validator: (value) =>
                              validateField(value, RegExp(r'^[0-9]+$')),
                          onChanged: (value) =>
                              formKey.currentState?.validate()),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: location,
                          keyboardType: TextInputType.streetAddress,
                          maxLength: 15,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Dirección",
                              hintText: "Ingresar Dirección"),
                          validator: (value) => validateField(
                              value, RegExp(r'^[a-z A-Z 0-9 , .]+$')),
                          onChanged: (value) =>
                              formKey.currentState?.validate()),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 60,
                          width: 150,
                          child: MaterialButton(
                            height: 50,
                            color: Colors.amber,
                            onPressed: () async {
                              final idUser =
                                  client.auth.currentSession!.user.id;
                              final obj = await registerMetadata.insertData(
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
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
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
