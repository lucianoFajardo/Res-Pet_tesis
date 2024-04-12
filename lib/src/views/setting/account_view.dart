import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/models/user_data.dart';
import '../../bloc/get_data/user_information/get_user_information_cubit.dart';

class ViewAccount extends StatefulWidget {
  const ViewAccount({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ViewAccountState createState() => _ViewAccountState();
}

class _ViewAccountState extends State<ViewAccount> {
  late final GetUserInformationCubit getUserInformationCubit;
  @override
  void initState() {
    super.initState();
    getUserInformationCubit = GetUserInformationCubit();
    getUserInformationCubit.getUserInformation();
  }
  @override
  Widget build(BuildContext context) {
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
      body: BlocConsumer<GetUserInformationCubit, GetUserInformationState>(
        bloc: getUserInformationCubit,
        listener: (context, state) {
        },
        builder: (context, state) {
          if (state is UserInformationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserInformationAllData) {
            final stateData = state.informationUser.first; 
            return Padding(
              padding: const EdgeInsets.all(8.0), 
              child: Column(
                children: [
                  Text(stateData.idUser),
                  Text("Nombre: ${stateData.name}"),
                  Text("Apellido: ${stateData.lastName}"),
                  Text("Celular: ${stateData.celphoneNumber}"),
                  Text("Direccion: ${stateData.locationUser}"),
                ],
              ),
            );
          } else if (state is UserInformationError) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
