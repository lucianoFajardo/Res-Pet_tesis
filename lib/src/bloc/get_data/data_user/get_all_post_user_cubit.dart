import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_pet.dart';

part 'get_all_post_user_state.dart';

class GetAllPostUserCubit extends Cubit<GetAllPostUserState> {
  GetAllPostUserCubit() : super(GetAllPostUserInitial());

  Future getAllPostMyUser() async {
    // traer solo los datos de publicacion que sean solo los del usuario seleccionado.
    // mostrar solamente sus datos.
    // (Bastian ) Modificar los datos.
    try {
      emit(LoadingPostState());
      final resdata = await client
          .from('publicaciones_prueba')
          .select('*,profile_data_user!inner(user_name)')
          .eq('id_user_created', client.auth.currentSession!.user.id)
          .execute();
      final data = resdata.data as List;
      List<data_pet> dataList = data.map((i) {
        return data_pet(
            id_pet: i['id_pet'],
            gender: i['gender'],
            createdAt: i['created_at'],
            years: i['years_pet'],
            location: i['location_pet'],
            name: i['name_pet'],
            id_User: i['id_user_created'],
            id_photo_pet: i['photo_pet'],
            nameUser: i['profile_data_user']['user_name']);
      }).toList();
      emit(AlldataPostState(dataPost: dataList));
      return dataList;
    } catch (e) {
      emit(ErrorPostState('error encontrado -> ${e.toString()}'));
      // en caso de error devolver una lista vacia.
    }
  }
}
