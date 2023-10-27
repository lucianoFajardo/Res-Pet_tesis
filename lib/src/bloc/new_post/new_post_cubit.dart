import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'new_post_state.dart';

class NewPostCubit extends Cubit<NewPostState> {
  final supabase = Supabase.instance.client;
  
  NewPostCubit() : super(NewPostInitial());

  // ignore: non_constant_identifier_names
  Future<void> NewPostUpload({
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

    required final imagenPath,
    required final imagenBytes,
    required final imagenTipo,

  }) async {
    try {
      
      await supabase.storage
        .from("imagenes")
        .uploadBinary(imagenPath, imagenBytes!, fileOptions: FileOptions(contentType: "imagen/$imagenTipo"));

      await supabase
        .from("created_post_adoption_pet")
        .insert({'photo_pet': fotoMascota, 'name_pet': nombreMascota, 'description_pet': descripcionMascota, 'fur_color': colorPelaje, 
                'weight_pet': pesoMascota, 'age_pet': edadMascota, 'gender_pet': generoMascota, 'location': localidadMascota, 
                'is_sterilization': esterilizadoMascota, 'size_pet': tamanoMascota, 'specific_care': cuidadoMascota});
        
        emit(NewPostSuccessful());
      // ignore: avoid_print
      print("Post de Adopcion Creado");

    }catch (e){

      emit(NewPostFailed(e.toString()));
      // ignore: avoid_print
      print("Error: $e");
    }
  }
}
