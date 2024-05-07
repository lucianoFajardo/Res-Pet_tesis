// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'new_post_perdida_state.dart';

class NewPostPerdidaCubit extends Cubit<NewPostPerdidaState> {
  
  NewPostPerdidaCubit() : super(NewPostPerdidaInitial());

  // ignore: non_constant_identifier_names
  Future<void> NewPostPerdidaUpload({
    required String descripcionMascota,
    required String fotoMascota,
    required String nombreMascota,
    required String colorPelaje,
    required String generoMascota,
    required String localidadMascota,

    required int pesoMascota,
    required int edadMascota,
    required int tamanoMascota,

    required final imagenPath,
    required final imagenBytes,
    required final imagenTipo,
    required final usuarioID,

  })async{
    try{
      await client.storage
        .from("imagenesPerdida")
        .uploadBinary(imagenPath, imagenBytes!, fileOptions: FileOptions(contentType: "imagenPerdida/$imagenTipo"));

      await client
        .from("created_post_lost_pet")
        .insert({'photo_pet': fotoMascota, 'description_pet' : descripcionMascota, 'name_pet': nombreMascota,
                'fur_color': colorPelaje, 'weight_pet': pesoMascota, 'age_pet': edadMascota, 'gender_pet': generoMascota,
                'location': localidadMascota, 'size_pet': tamanoMascota, 'id_user_created': usuarioID});

      emit(NewPostPerdidaSuccessful());
      print("Post de Animal Perdido Creado");

    }catch (e){
      emit(NewPostPerdidaFailed(e.toString()));
      print("Error Cubit: $e");
    }
  }
}
