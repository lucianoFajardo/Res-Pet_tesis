import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/views/pet_profile/perfil.dart';

import '../../bloc/get_data/data_post_all/get_all_data_pets_cubit.dart';

class ViewDataAllPet extends StatefulWidget {
  const ViewDataAllPet({super.key});

  @override
  State<ViewDataAllPet> createState() => _GridCState();
}

class _GridCState extends State<ViewDataAllPet> {
  OperationCrudCubit petdatas = OperationCrudCubit();
  @override
  void initState() {
    final petdatas = context.read<OperationCrudCubit>();
    petdatas.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OperationCrudCubit, OperationCrudState>(
      listener: (context, state) {
        if (state is ErrorStateOperation) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingStateOperation) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AllDataGet) {
          return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                final petDataGet = state.data[index];
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber[300]),
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PerfilViewData(
                                          dataPetGet: petDataGet,
                                        )));
                          },
                          title: Text(petDataGet.name_pet),
                          subtitle: Text('${petDataGet.age_pet.toString()} años'),
                          leading: ClipRRect(
                            child: Image.network(
                              petDataGet.id_photo_pet,
                              cacheHeight: 100,
                              cacheWidth: 100,
                            ),
                          ),
                          trailing: gender(petDataGet.gender_pet.toString())),
                    ));
              });
        }
        if (state is ErrorStateOperation) {
          return Center(child: Text(state.error.toString()));
        }
        return Center(
          child: Text(petdatas.toString()),
        );
      },
    );
  }
}

gender(String gender) {
  if (gender == 'Macho') {
    return const Icon(
      Icons.male,
      color: Colors.blue,
      size: 55.0,
    );
  } else {
    return const Icon(
      Icons.female,
      color: Colors.pink,
      size: 55.0,
    );
  }
}

