import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_pet.dart';

part 'get_data_five_pets_state.dart';

class GetDataFivePetsCubit extends Cubit<GetDataFivePetsState> {
  GetDataFivePetsCubit() : super(GetDataFivePetsInitial());

    Future fiveGetData() async {
    try {
      emit(LoadingDataFive());
      final resdata = await client
          .from('publicaciones_prueba')
          .select('*,profile_data_user!inner(user_name)')
          .order('created_at', ascending: true)
          .limit(3).execute();
      final dataFiveGet = resdata.data as List;
      List<data_pet> dataListPet = dataFiveGet.map((i) {
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
      emit(GetDatafiveStateOperation(data: dataListPet)); 
      return dataFiveGet ;
    } catch (e) {
      emit(ErrorStateOperation('error encontrado -> ${e.toString()}'));
      // en caso de error devolver una lista vacia.
    }
  }
}
