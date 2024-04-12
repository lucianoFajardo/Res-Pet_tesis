import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get_data/user_information/get_user_information_cubit.dart';

class ViewAccount extends StatelessWidget {
  final getUserInformationCubit = GetUserInformationCubit();

  @override
  Widget build(BuildContext context) {
    // Llama al método para obtener la información del usuario
    getUserInformationCubit.getUserInformation();
    print(getUserInformationCubit);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis datos'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<GetUserInformationCubit, GetUserInformationState>(
        builder: (context, state) {
          if (state is UserInformationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserInformationAllData) {
            // Aquí muestras la información del usuario
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Nombre: ${state.informationUser.nombre}"),
                  Text('Apellido: ${state.informationUser.apellido}'),
                  Text('Teléfono: ${state.informationUser.telefono}'),
                  Text('Dirección: ${state.informationUser.direccion}'),
                  //TODO : Aquí el usuario debe poder editar sus datos, como nombre, apellido, teléfono, dirección
                ],
              ),
            );
          } else if (state is UserInformationError) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Center(
              child: Text('Estado desconocido'),
            );
          }
        },
      ),
    );
  }
}
