// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_pet.dart';

part 'get_data_filter_pets_state.dart';

class GetDataFivePetsCubit extends Cubit<GetDataFivePetsState> {
  GetDataFivePetsCubit() : super(GetDataFivePetsInitial());
//profile_data_user!inner(user_name)
  Future threGetData() async {
    try {
      emit(LoadingDataFive());
      final resdata = await client
          .from('created_post_adoption_pet')
          .select('*, user_metadata!inner(name_user,celphone_number)')  
          .order('created_at', ascending: false)
          .limit(3)
          .execute();
      final dataFiveGet = resdata.data as List;
      List<data_pet> dataListPet = dataFiveGet.map((i) {
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
      emit(GetDatafiveStateOperation(data: dataListPet));
      return dataFiveGet;
    } catch (e) {
      emit(ErrorStateOperation('error encontrado -> ${e.toString()}'));
      return [];
    }
  }
}
