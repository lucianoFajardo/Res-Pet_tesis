part of 'get_data_filter_pets_cubit.dart';

abstract class GetDataFivePetsState extends Equatable {
  const GetDataFivePetsState();
  @override
  List<Object> get props => [];
}

class GetDataFivePetsInitial extends GetDataFivePetsState {}

class LoadingDataFive extends GetDataFivePetsState {}

class GetDatafiveStateOperation extends GetDataFivePetsState{
  final List<data_pet> data;
  const GetDatafiveStateOperation({required this.data});
}

class ErrorStateOperation extends GetDataFivePetsState{
  final String? error;
  const ErrorStateOperation(this.error);
}

