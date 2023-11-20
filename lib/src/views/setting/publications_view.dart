import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:respet_app/src/bloc/get_data/data_user/get_all_post_user_cubit.dart';
import 'package:respet_app/src/views/edit_post/edit_post_view.dart';
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
                                  title: Text(petDataGet.name_pet),
                                  subtitle: Text(petDataGet.age_pet.toString()),
                                  leading: ClipRRect(
                                    child: Image.network(
                                      'https://images.dog.ceo/breeds/spaniel-japanese/n02085782_1774.jpg',
                                      height: 100,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      //! en este apartado tengo que capturar la data del indice que seleccione de la publicacion y se la
                                      //! mando al otro estado que es para editar esa data seleccionada.
                                      //? Aqui se tiene que mandar los datos mediante el contexto,
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPostView(
                                                      dataPetGetEdit:
                                                          petDataGet)));
                                    },
                                  )),
                            ));
                      });
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ));
  }
}

//TODO -> tener en cuenta luego el eliminar una publicacion y con eso se terminaria el CRUD

/**
 *                                     petDataGet.gender_pet
                                        ? Icons.male
                                        : Icons.female,
                                    color: petDataGet.gender_pet
                                        ? Colors.blue
                                        : Colors.pink,


                                         actions: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 11),
                  child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text("Modificar")))
            ]
 */
