import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/user_data.dart';
part 'register_metadata_state.dart';

class RegisterMetadataCubit extends Cubit<RegisterMetadataState> {
  RegisterMetadataCubit() : super(RegisterMetadataInitial());
  Future<void> insertData(userMetaData userData) async {
    try {
      emit(RegisterLoadingMetadataState());
      await client.from('user_metadata').insert([
        {
          'id_user': userData.idUser,
          'name_user': userData.name,
          'last_name': userData.lastName,
          'celphone_number':userData.celphoneNumber,
          'location_user': userData.locationUser
        }
      // ignore: deprecated_member_use
      ]).execute();
      emit(RegisterUploadMetadataState());
    } catch (e) {
      emit(RegisterErrorMetadataState(e.toString()));
    }
  }
}
