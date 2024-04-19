part of 'new_post_perdida_cubit.dart';

sealed class NewPostPerdidaState extends Equatable {
  const NewPostPerdidaState();

  @override
  List<Object> get props => [];
}

final class NewPostPerdidaInitial extends NewPostPerdidaState {}

final class  NewPostPerdidaSuccessful extends NewPostPerdidaState {}

final class  NewPostPerdidaFailed extends NewPostPerdidaState {
  final String errorView;
  const NewPostPerdidaFailed(this.errorView);
}

final class  NewPostPerdidaLoading extends NewPostPerdidaState {}
