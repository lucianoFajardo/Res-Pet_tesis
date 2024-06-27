import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
import 'package:respet_app/src/models/user_data.dart';
part 'get_user_information_state.dart';

class GetUserInformationCubit extends Cubit<GetUserInformationState> {
  GetUserInformationCubit() : super(GetUserInformationInitial());
  Future getUserInformation() async {
    try {
      emit(UserInformationLoading());
      // ignore: deprecated_member_use
      final resDataUser = await client
          .from('user_metadata')
          .select('*')
          .eq('id_user', client.auth.currentSession!.user.id)
          .execute();
      final dataUser = resDataUser.data as List;
      List<userMetaData> userDataList = dataUser.map((e) {
        return userMetaData(
            name: e['name_user'],
            lastName: e['last_name'],
            celphoneNumber: e['celphone_number'],
            idUser: e['id_user'],
            locationUser: e['location_user']);
      }).toList();
      emit(UserInformationAllData(informationUser: userDataList));
      return dataUser;
    } catch (e) {
      emit(UserInformationError(error: e.toString()));
    }
  }
}
