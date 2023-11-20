part of 'edit_post_cubit.dart';

sealed class EditPostState extends Equatable {
  const EditPostState();

  @override
  List<Object> get props => [];
}

final class EditPostInitial extends EditPostState {}

final class EditPostSuccessful extends EditPostState {

}

final class EditPostFailed extends EditPostState {
  final String errorView;
  const EditPostFailed(this.errorView);
}

final class EditPostLoading extends EditPostState {

}
