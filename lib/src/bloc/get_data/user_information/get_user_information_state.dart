part of 'get_user_information_cubit.dart';

abstract class GetUserInformationState extends Equatable {
  const GetUserInformationState();
  @override
  List<Object> get props => [];
}
class UserInformationError extends GetUserInformationState {
  final String? error;
  const UserInformationError({required this.error});
}

class UserInformationLoading extends GetUserInformationState {}

class UserInformationAllData extends GetUserInformationState {
  final List<userMetaData> informationUser;
  const UserInformationAllData({required this.informationUser});
}

class GetUserInformationInitial extends GetUserInformationState {}


