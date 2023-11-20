import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/data_pet.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  EditPostCubit() : super(EditPostInitial());

  Future<void> EditPostUpdate({
  
    required String fotoMascota,
    required String nombreMascota,
    required String descripcionMascota,
    required String colorPelaje,
    required double pesoMascota,
    required int edadMascota,
    required String generoMascota,
    required String localidadMascota,
    required bool esterilizadoMascota,
    required int tamanoMascota,
    required String cuidadoMascota,
    //todo implementar el bloc en el edit_post_view, verificar si se actualiza y funciona el cambio de imagen en el bucket
  })async{
    try{
      emit(EditPostLoading());

      final infoSupDes = await client.from("created_post_adoption_pet").select("*");
      print(infoSupDes);

      final dataList = infoSupDes.map((i){
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
        );
      });

      emit(EditPostSuccessful());

    }catch(e){
      emit(EditPostFailed(e.toString()));
    }
  }
}
