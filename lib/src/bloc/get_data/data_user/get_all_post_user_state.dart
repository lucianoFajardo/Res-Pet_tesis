part of 'get_all_post_user_cubit.dart';

abstract class GetAllPostUserState extends Equatable {
  const GetAllPostUserState();

  @override
  List<Object> get props => [];
}

class GetAllPostUserInitial extends GetAllPostUserState {}

class LoadingPostState extends GetAllPostUserState {}

class ErrorPostState extends GetAllPostUserState {
  final String error;
  const ErrorPostState(this.error);
}

class AlldataPostState extends GetAllPostUserState {
  final List<data_pet> dataPost;
  const AlldataPostState({required this.dataPost});
}
