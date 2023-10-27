import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/CRUD/get_data_five_pets_cubit.dart';
import 'package:respet_app/src/views/pet_profile/perfil.dart';

class GridC extends StatefulWidget {
  const GridC({super.key});

  @override
  State<GridC> createState() => _GridCState();
}

class _GridCState extends State<GridC> {
  GetDataFivePetsCubit petdata = GetDataFivePetsCubit();

  @override
  void initState() {
    final petdata = context.read<GetDataFivePetsCubit>();
    petdata.fiveGetData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDataFivePetsCubit, GetDataFivePetsState>(
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
          return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                final petDataGet = state.data[index];
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
                            color:
                                petDataGet.gender ? Colors.blue : Colors.pink,
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
    );
  }
}
