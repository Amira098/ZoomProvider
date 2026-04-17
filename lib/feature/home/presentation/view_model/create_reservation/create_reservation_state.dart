import '../../../../../core/models/api_error.dart';
import '../../../data/model/create_reservation_model.dart';

abstract class CreateReservationState {}

class CreateReservationInitial extends CreateReservationState {}

class CreateReservationLoading extends CreateReservationState {}

class CreateReservationSuccess extends CreateReservationState {
  final CreateReservationModel createReservationModel;

  CreateReservationSuccess({required this.createReservationModel});
}

class CreateReservationFailure extends CreateReservationState {
  final ApiError? apiError;
  final Exception? exception;

  CreateReservationFailure({this.apiError, this.exception});
}
