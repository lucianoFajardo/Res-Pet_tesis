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
          .from('created_post_adoption_pet')
          .select('*,user_metadata!inner(name_user,celphone_number)')
          .eq('id_user_created', client.auth.currentSession!.user.id)
          .execute();
      final data = resdata.data as List;
      List<data_pet> dataList = data.map((i) {
        return data_pet(
            id_pet: i['id_pet_adoption'],
            id_photo_pet: i['photo_pet'],
            description_pet: i['description_pet'],
            fur_color: i['fur_color'],
            weight_pet: i['weight_pet'],
            age_pet: i['age_pet'],
            gender_pet: i['gender_pet'],
            location: i['location'],
            is_sterilization: i['is_sterilization'],
            id_User: i['id_user_created'],
            createdAt: i['created_at'],
            size_pet: i['size_pet'],
            specific_care: i['specific_care'],
            name_pet: i['name_pet'],
            vaccines_pet: i['vaccines_pet'],
            celphoneUser: i['user_metadata']['celphone_number'],
            nameUser: i['user_metadata']['name_user']);
      }).toList();
      emit(AlldataPostState(dataPost: dataList));
      return dataList;
    } catch (e) {
      emit(ErrorPostState('error encontrado -> ${e.toString()}'));
      // en caso de error devolver una lista vacia.
    }
  }
}// nameUser: i['profile_data_user']['user_name']
