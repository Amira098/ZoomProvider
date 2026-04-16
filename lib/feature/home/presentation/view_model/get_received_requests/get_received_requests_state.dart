import '../../../../../core/models/api_error.dart';
import '../../../data/model/get_received_requests_model.dart';

abstract class GetReceivedRequestsState {}

class GetReceivedRequestsInitial extends GetReceivedRequestsState {}

class GetReceivedRequestsLoading extends GetReceivedRequestsState {}

class GetReceivedRequestsSuccess extends GetReceivedRequestsState {
  final GetReceivedRequestsModel receivedRequestsModel;

  GetReceivedRequestsSuccess({required this.receivedRequestsModel});
}

class GetReceivedRequestsFailure extends GetReceivedRequestsState {
  final ApiError? apiError;
  final Exception? exception;

  GetReceivedRequestsFailure({this.apiError, this.exception});
}
