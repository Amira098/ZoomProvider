import '../../../../../core/models/api_error.dart';
import '../../../data/model/create_patient_model.dart';

abstract class CreatePatientState {}

class CreatePatientInitial extends CreatePatientState {}

class CreatePatientLoading extends CreatePatientState {}

class CreatePatientSuccess extends CreatePatientState {
  final CreatePatientModel createPatientModel;

  CreatePatientSuccess({required this.createPatientModel});
}

class CreatePatientFailure extends CreatePatientState {
  final ApiError? apiError;
  final Exception? exception;

  CreatePatientFailure({this.apiError, this.exception});
}
