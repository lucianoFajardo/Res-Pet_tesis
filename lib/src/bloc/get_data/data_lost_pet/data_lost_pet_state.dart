part of 'data_lost_pet_cubit.dart';

abstract class DataLostPetState extends Equatable {
  const DataLostPetState();

  @override
  List<Object> get props => [];
}

class DataLostPetInitial extends DataLostPetState {}

class DataLostPetLoading extends DataLostPetState{}

class DataLostPetError extends DataLostPetState {
  final String error;
  const DataLostPetError({required this.error});
}

class DataLostPetThreData extends DataLostPetState{
  final List<data_Lost_Pet> dataLostPetList;
  const DataLostPetThreData({required this.dataLostPetList});
}

