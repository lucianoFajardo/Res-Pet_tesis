part of 'get_all_data_pets_cubit.dart';

abstract class OperationCrudState extends Equatable {
  const OperationCrudState();
  @override
  List<Object> get props => [];
}

class OperationCrudInitial extends OperationCrudState {}

class LoadingStateOperation extends OperationCrudState {}

class AllDataGet extends OperationCrudState {
  final List<data_pet> data;
  const AllDataGet({required this.data});
}

class ErrorStateOperation extends OperationCrudState {
  final String? error;
  const ErrorStateOperation(this.error);
}

