import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:respet_app/main.dart';
part 'get_user_information_state.dart';

class GetUserInformationCubit extends Cubit<GetUserInformationState> {
  GetUserInformationCubit() : super(GetUserInformationInitial());
  Future getUserInformation() async {
    try {
      emit(UserInformationLoading());
      final resDataUser =
          await client.from('user_metadata').select('*').eq('id_user', client.auth.currentSession!.user.id);
      print(resDataUser);
      emit(UserInformationAllData(informationUser: resDataUser));
    } catch (e) {
      emit(UserInformationError(error: 'error userData -> ${e.toString()}'));
    }
  }
}
