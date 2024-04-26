import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/get_data/data_lost_pet/data_lost_pet_cubit.dart';

class ListDataLostPet extends StatefulWidget {
  const ListDataLostPet({super.key});

  @override
  State<ListDataLostPet> createState() => _ListDataLostPetState();
}

class _ListDataLostPetState extends State<ListDataLostPet> {
  DataLostPetCubit _dataLostPet = DataLostPetCubit();

  @override
  void initState() {
    _dataLostPet = context.read<DataLostPetCubit>();
    _dataLostPet.getDataLostPet();
    super.initState();
  }

  Future _refreshDataLost() async {
    _dataLostPet = context.read();
    await _dataLostPet.getDataLostPet();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshDataLost,
        child: BlocConsumer<DataLostPetCubit,DataLostPetState>(
            builder: (context, state) {
              if (state is DataLostPetLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state is DataLostPetThreData) {
                return state.dataLostPetList.isEmpty ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
                  itemCount: state.dataLostPetList.length,
                  itemBuilder: (BuildContext context , int i) {
                    final dataLostPet = state.dataLostPetList[i];
                    return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber[300]),
                            child: ListTile(
                                onTap: () {
                                //  Navigator.push(
                                  //    context,
                                    //  MaterialPageRoute(
                                      //    builder: (context) => PerfilViewData(
                                        //        dataPetGet: dataLostPet,
                                          //    )));
                                },
                                title: Text(dataLostPet.name_pet),
                                subtitle: Text(
                                    "${dataLostPet.age_pet.toString()} años"),
                                trailing:
                                    gender(dataLostPet.gender_pet.toString())),
                          ));
                  });
              }
              if (state is DataLostPetError) {
                return Center(child: Text(state.error.toString()));
                
              }
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            },
            listener: (context, state) {
              if (state is DataLostPetError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error.toString()),
                  duration: const Duration(hours: 1),
                ));
              }
            }));
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