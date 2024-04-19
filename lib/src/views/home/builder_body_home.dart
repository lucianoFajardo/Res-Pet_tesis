// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/views/pet_profile/perfil.dart';

import '../../bloc/get_data/data_post_filter/get_data_filter_pets_cubit.dart';

class ListViewData extends StatefulWidget {
  const ListViewData({super.key});
  @override
  State<ListViewData> createState() => _ListViewDataState();
}

class _ListViewDataState extends State<ListViewData> {
  GetDataFivePetsCubit _petdata = GetDataFivePetsCubit();

  @override
  void initState() {
    _petdata = context.read<GetDataFivePetsCubit>();
    _petdata.threGetData();
    super.initState();
  }

  Future _refreshData() async {
    _petdata = context.read<GetDataFivePetsCubit>();
    await _petdata.threGetData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: BlocConsumer<GetDataFivePetsCubit, GetDataFivePetsState>(
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
          if (state is LoadingDataFive) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetDatafiveStateOperation) {
            return state.data.isEmpty
                ? const Text('No existen publicaciones disponibles.')
                : ListView.builder(
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
                                subtitle: Text(
                                    "${petDataGet.age_pet.toString()} años"),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    petDataGet.id_photo_pet,
                                    cacheHeight: 100,
                                    cacheWidth: 100,
                                  ),
                                ),
                                trailing:
                                    gender(petDataGet.gender_pet.toString())),
                          ));
                    });
          }
          if (state is ErrorStateOperation) {
            return Center(child: Text(state.error.toString()));
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        },
      ),
    );
  }
}

gender(String gender) {
  if (gender == 'Macho') {
    return const Icon(
      Icons.male,
      color: Colors.blue,
      size: 40.0,
    );
  } else {
    return const Icon(
      Icons.female,
      color: Colors.pink,
      size: 40.0,
    );
  }
}

