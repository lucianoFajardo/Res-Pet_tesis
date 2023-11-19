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
                ? const Text('No existen post disponibles.')
                : ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final petDataGet = state.data[index];
                      print(petDataGet.years);
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber),
                            child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PerfilViewData(
                                                dataPetGet: petDataGet,
                                              )));
                                },
                                title: Text(petDataGet.name),
                                subtitle: Text(petDataGet.years),
                                leading: ClipRRect(
                                  child: Image.network(
                                    'https://images.dog.ceo/breeds/spaniel-japanese/n02085782_1774.jpg',
                                    height: 100,
                                  ),
                                ),
                                trailing: Icon(
                                  petDataGet.gender ? Icons.male : Icons.female,
                                  color: petDataGet.gender
                                      ? Colors.blue
                                      : Colors.pink,
                                )),
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
