// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());

  Future<void> DeletePostPublication({
    required String idPet,
    required String pathImagen,
  }) async{
    try{
      emit(DeletePostLoading());
      String pathImagen2 = pathImagen.substring(75);
      await client
        .from("created_post_adoption_pet")
        .delete()
        .match({"id_pet_adoption": idPet});
      client.storage
        .from('imagenes$pathImagen2')
        .remove([pathImagen2])
        .ignore();
      emit(DeletePostSuccessful());
    }catch (e){
      emit(DeletePostFailed(e.toString()));
      print("Error : $e");
    }
  }
}
