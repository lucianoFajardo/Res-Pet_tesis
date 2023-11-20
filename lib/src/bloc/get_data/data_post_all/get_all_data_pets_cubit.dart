// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_pet.dart';
part 'get_all_data_pets_state.dart';

class OperationCrudCubit extends Cubit<OperationCrudState> {
  OperationCrudCubit() : super(OperationCrudInitial());
  Future getData() async {
    try {
      emit(LoadingStateOperation());
      final resdata = await client
          .from('publicaciones_prueba')
          .select('*,user_metadata!inner(name_user,celphone_number)')
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
      emit(AllDataGet(data: dataList));
      return data;
    } catch (e) {
      emit(ErrorStateOperation('error encontrado -> ${e.toString()}'));
      // en caso de error devolver una lista vacia.
    }
  }
}
