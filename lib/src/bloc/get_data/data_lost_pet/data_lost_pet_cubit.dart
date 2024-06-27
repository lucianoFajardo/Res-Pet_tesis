import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_lost_pet.dart';

part 'data_lost_pet_state.dart';

class DataLostPetCubit extends Cubit<DataLostPetState> {
  DataLostPetCubit() : super(DataLostPetInitial());
  Future getDataLostPet() async {
    try {
      emit(DataLostPetLoading());
      final resLostPet =
          await client.from('created_post_lost_pet').select('*,user_metadata!inner(name_user,celphone_number)').range(0,2).execute();
      final listLostPet = resLostPet.data as List;
      List<data_Lost_Pet> dataLostPet = listLostPet.map((e) {
        return data_Lost_Pet( id_pet_adoption: e['id_pet_adoption'],
        photo_pet: e['photo_pet'],
        description_pet: e['description_pet'],
        fur_color: e['fur_color'],
        weight_pet: e['weight_pet'],
        age_pet: e['age_pet'],
        gender_pet: e['gender_pet'],
        location: e['location'],
        size_pet: e['size_pet'],
        created_at: e['created_at'],
        name_pet: e['name_pet'],
        id_user_created: e['id_user_created'],
        celphoneUser: e['user_metadata']['celphone_number'],
        nameUser: e['user_metadata']['name_user'],
        modificated_at: e['modificated_at']);
      }).toList();
      emit(DataLostPetThreData(dataLostPetList: dataLostPet));
      return dataLostPet;
    } catch (e) {
      emit(DataLostPetError(error: e.toString()));
    }
  }
}
