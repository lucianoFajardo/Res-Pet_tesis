part of 'new_post_cubit.dart';

sealed class NewPostState extends Equatable {
  const NewPostState();

  @override
  List<Object> get props => [];
}

final class NewPostInitial extends NewPostState {

}

final class NewPostSuccessful extends NewPostState {
  
}

final class NewPostFailed extends NewPostState {
  final String errorView;
  const NewPostFailed(this.errorView);
}

final class NewPostLoading extends NewPostState {

}