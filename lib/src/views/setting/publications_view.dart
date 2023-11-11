import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/get_data/data_user/get_all_post_user_cubit.dart';
import 'package:respet_app/src/views/pet_profile/perfil.dart';

class ViewPublications extends StatefulWidget {
  const ViewPublications({super.key});
  @override
  State<ViewPublications> createState() => _ViewPublicationsState();
}

class _ViewPublicationsState extends State<ViewPublications> {
  GetAllPostUserCubit dataUser = GetAllPostUserCubit();

  @override
  void initState() {
    super.initState();
    final dataUser = context.read<GetAllPostUserCubit>();
    dataUser.getAllPostMyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis publicaciones'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios, //flecha de regreso //
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<GetAllPostUserCubit, GetAllPostUserState>(
              listener: (context, state) {
            if (state is ErrorPostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }, builder: (context, state) {
            if (state is ErrorPostState) {
              return Text(state.error.toString());
            }
            if (state is AlldataPostState) {
              return state.dataPost.isEmpty
                  ? const Center(child: Text('Aún no tienes publicaciones creadas.'))
                  : ListView.builder(
                      itemCount: state.dataPost.length,
                      itemBuilder: (BuildContext context, int index) {
                        final petDataGet = state.dataPost[index];
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
                                            builder: (context) =>
                                                PerfilViewData(
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
                                    petDataGet.gender
                                        ? Icons.male
                                        : Icons.female,
                                    color: petDataGet.gender
                                        ? Colors.blue
                                        : Colors.pink,
                                  )),
                            ));
                      });
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ));
  }
}
