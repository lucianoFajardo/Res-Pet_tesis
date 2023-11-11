part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccessfull extends RegisterState {
  final String idUser;
  const RegisterSuccessfull({required this.idUser});
}

class RegisterFailed extends RegisterState {
  final String errorView;
  const RegisterFailed(this.errorView);
}

class RegisterLoading extends RegisterState {}
