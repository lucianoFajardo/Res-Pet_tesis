part of 'register_metadata_cubit.dart';

abstract class RegisterMetadataState extends Equatable {
  const RegisterMetadataState();

  @override
  List<Object> get props => [];
}

class RegisterMetadataInitial extends RegisterMetadataState {}

class RegisterLoadingMetadataState extends RegisterMetadataState {}

class RegisterErrorMetadataState extends RegisterMetadataState {
  final String error;
  const RegisterErrorMetadataState(this.error);
}

class RegisterUploadMetadataState extends RegisterMetadataState {
}
