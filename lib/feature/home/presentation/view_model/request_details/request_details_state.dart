import '../../../../../core/models/api_error.dart';
import '../../../data/model/requests_details_model.dart';

abstract class RequestDetailsState {}

class RequestDetailsInitial extends RequestDetailsState {}

class RequestDetailsLoading extends RequestDetailsState {}

class RequestDetailsSuccess extends RequestDetailsState {
  final RequestsDetailsModel requestsDetailsModel;

  RequestDetailsSuccess({required this.requestsDetailsModel});
}

class RequestDetailsFailure extends RequestDetailsState {
  final ApiError? apiError;
  final Exception? exception;

  RequestDetailsFailure({this.apiError, this.exception});
}
