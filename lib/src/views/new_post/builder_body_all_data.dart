import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/CRUD/operation_crud_cubit.dart';
import 'package:respet_app/src/views/pet_profile/perfil.dart';

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
        return Center(
          child: Text(petdatas.toString()),
        );
      },
    );
  }
}
