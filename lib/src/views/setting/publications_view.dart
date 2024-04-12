// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/delete_post/delete_post_cubit.dart';
import 'package:respet_app/src/bloc/get_data/data_user/get_all_post_user_cubit.dart';
import 'package:respet_app/src/views/edit_post/edit_post_view.dart';
import 'package:respet_app/src/views/pet_profile/perfil.dart';
import 'package:timer_button/timer_button.dart';

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
    final deletePostCubitState = BlocProvider.of<DeletePostCubit>(context);
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
                  ? const Center(
                      child: Text('Aún no tienes publicaciones creadas.'))
                  : ListView.builder(
                      itemCount: state.dataPost.length,
                      itemBuilder: (BuildContext context, int index) {
                        final petDataGet = state.dataPost[index];
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
                                            builder: (context) =>
                                                PerfilViewData(
                                                    dataPetGet: petDataGet)));
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
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Center(
                                                      child: Text("Eliminar")),
                                                  content: const Text(
                                                      "¿Desea Eliminar este Post?"),
                                                  actions: <Widget>[
                                                    BlocConsumer<DeletePostCubit, DeletePostState>(
                                                      listener:(context, state) {
                                                        
                                                        if(state is DeletePostFailed){
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text(state.errorView.toString()),
                                                                duration: const Duration(seconds: 6),
                                                              ),
                                                            );
                                                          }

                                                        if(state is DeletePostSuccessful){
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            const SnackBar(
                                                                content: Text("Publicacion Eliminada."),
                                                                duration: Duration(seconds: 6)
                                                              )
                                                          );

                                                          Navigator.pushReplacementNamed(context, "home_view");
                                                        }
                                                      },

                                                      builder:(context, state) {
                                                        return TimerButton(
                                                            buttonType: ButtonType.textButton,
                                                            label: "Si",
                                                            timeOutInSeconds: 0,
                                                            color: Colors.deepPurple,
                                                            onPressed: () {
                                                              deletePostCubitState.DeletePostPublication(
                                                                idPet: petDataGet.id_pet, pathImagen: petDataGet.id_photo_pet);
                                                              }
                                                          );
                                                      },
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },

                                                      child: const Text("No")
                                                    )
                                                  ],
                                                )),
                                        icon: const Icon(
                                            Icons.delete_forever_rounded),
                                        color: Colors.black,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Colors.black,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPostView(
                                                          dataPetGetEdit:
                                                              petDataGet)));
                                        },
                                      ),
                                    ],
                                  )),
                            ));
                      });
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ));
  }
}
