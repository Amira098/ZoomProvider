import '../../../../../core/models/api_error.dart';
import '../../../data/model/all_requests_model.dart';

abstract class AllRequestsState {}

class AllRequestsInitial extends AllRequestsState {}

class AllRequestsLoading extends AllRequestsState {}

class AllRequestsSuccess extends AllRequestsState {
  final AllRequestsModel allRequestsModel;

  AllRequestsSuccess({required this.allRequestsModel});
}

class AllRequestsFailure extends AllRequestsState {
  final ApiError? apiError;
  final Exception? exception;

  AllRequestsFailure({this.apiError, this.exception});
}
