import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_pet.dart';
part 'operation_crud_state.dart';

class OperationCrudCubit extends Cubit<OperationCrudState> {
  final List<data_pet> _favoritePet = [];

  OperationCrudCubit() : super(OperationCrudInitial());

  Future getData() async {
    try {
      emit(LoadingStateOperation());
      final resdata = await client
          .from('publicaciones_prueba')
          .select('*,profile_data_user!inner(user_name)').execute();
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
      emit(AllDataGet(data: dataList));
      return data;
    } catch (e) {
      emit(ErrorStateOperation('error encontrado -> ${e.toString()}'));
      // en caso de error devolver una lista vacia.
    }
  }



  void isFavorite(data_pet dataSelec) {
    emit(LoadingStateOperation());
    try {
      bool isFavPetBool = _favoritePet.contains(dataSelec);
      if (isFavPetBool) {
        _favoritePet
            .removeWhere((element) => element.id_pet == dataSelec.id_pet);
        dataSelec.isFavoritePet = false;
      } else {
        _favoritePet.add(dataSelec);
        dataSelec.isFavoritePet = true;
      }
    } catch (e) {
      emit(ErrorStateOperation('error en copia debido a -> ${e.toString()}'));
    }
  }
}
