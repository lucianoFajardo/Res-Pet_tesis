// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    required String vacunasMascota,
    required String mascotaID,
    required bool hayImagen,

    required final imagenBytes,
    required final imagenTipo,
    required final usuarioID,
    
  }) async {
    try {
      emit(EditPostLoading());

      String pathOriginal = fotoMascota.substring(113);
      String imagenPath = "/$usuarioID/$pathOriginal";

      if (hayImagen = true){

        await client.storage
        .from("imagenes")
        .updateBinary(imagenPath, imagenBytes, fileOptions: FileOptions(contentType: "imagen/$imagenTipo"));

        await client
        .from("created_post_adoption_pet")
        .update({'photo_pet': fotoMascota, 'name_pet': nombreMascota, 'description_pet': descripcionMascota, 'fur_color': colorPelaje, 
                'weight_pet': pesoMascota, 'age_pet': edadMascota, 'gender_pet': generoMascota, 'location': localidadMascota, 
                'is_sterilization': esterilizadoMascota, 'size_pet': tamanoMascota, 'specific_care': cuidadoMascota, 'vaccines_pet': vacunasMascota})
        .match({"id_pet_adoption": mascotaID, "id_user_created": usuarioID});

      }else{

        await client
        .from("created_post_adoption_pet")
        .update({'photo_pet': fotoMascota, 'name_pet': nombreMascota, 'description_pet': descripcionMascota, 'fur_color': colorPelaje, 
                'weight_pet': pesoMascota, 'age_pet': edadMascota, 'gender_pet': generoMascota, 'location': localidadMascota, 
                'is_sterilization': esterilizadoMascota, 'size_pet': tamanoMascota, 'specific_care': cuidadoMascota, 'vaccines_pet': vacunasMascota})
        .match({"id_pet_adoption": mascotaID, "id_user_created": usuarioID});

      }

      emit(EditPostSuccessful());

    } catch (e) {

      emit(EditPostFailed(e.toString()));
    }
  }
}
