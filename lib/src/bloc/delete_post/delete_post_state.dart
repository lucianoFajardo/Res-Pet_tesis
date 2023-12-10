part of 'delete_post_cubit.dart';

sealed class DeletePostState extends Equatable {
  const DeletePostState();

  @override
  List<Object> get props => [];
}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostSuccessful extends DeletePostState {}

final class DeletePostFailed extends DeletePostState {
  final String errorView;
  const DeletePostFailed(this.errorView);
}

final class DeletePostLoading extends DeletePostState {}