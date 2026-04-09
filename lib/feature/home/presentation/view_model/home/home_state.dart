
import '../../../../../core/models/api_error.dart';
import '../../../data/model/all_requests_model.dart';
import '../../../data/model/home_model.dart';
import '../../../data/model/requests_details_model.dart';


abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel homeModel;

  HomeSuccess({required this.homeModel});
}

class HomeFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  HomeFailure({this.apiError, this.exception});
}

class AllRequestsLoading extends HomeState {}

class AllRequestsSuccess extends HomeState {
  final AllRequestsModel allRequestsModel;

  AllRequestsSuccess({required this.allRequestsModel});
}

class AllRequestsFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  AllRequestsFailure({this.apiError, this.exception});
}

class RequestDetailsLoading extends HomeState {}

class RequestDetailsSuccess extends HomeState {
  final RequestsDetailsModel requestsDetailsModel;

  RequestDetailsSuccess({required this.requestsDetailsModel});
}

class RequestDetailsFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  RequestDetailsFailure({this.apiError, this.exception});
}
