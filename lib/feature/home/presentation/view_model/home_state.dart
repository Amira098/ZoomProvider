import '../../../../core/models/api_error.dart';
import '../../data/model/all_requests_model.dart';
import '../../data/model/complete_order_model.dart';
import '../../data/model/home_model.dart';
import '../../data/model/receive_order_model.dart';
import '../../data/model/requests_details_model.dart';
import '../../data/model/start_order_model.dart';
import '../../data/model/suspend_order_model.dart';
import '../../data/model/unsuspend_model.dart';

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

class ReceiveOrderLoading extends HomeState {}

class ReceiveOrderSuccess extends HomeState {
  final ReceiveOrderModel receiveOrderModel;

  ReceiveOrderSuccess({required this.receiveOrderModel});
}

class ReceiveOrderFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  ReceiveOrderFailure({this.apiError, this.exception});
}

class StartOrderLoading extends HomeState {}

class StartOrderSuccess extends HomeState {
  final StartOrderModel startOrderModel;

  StartOrderSuccess({required this.startOrderModel});
}

class StartOrderFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  StartOrderFailure({this.apiError, this.exception});
}

class SuspendOrderLoading extends HomeState {}

class SuspendOrderSuccess extends HomeState {
  final SuspendOrderModel suspendOrderModel;

  SuspendOrderSuccess({required this.suspendOrderModel});
}

class SuspendOrderFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  SuspendOrderFailure({this.apiError, this.exception});
}

class UnsuspendOrderLoading extends HomeState {}

class UnsuspendOrderSuccess extends HomeState {
  final UnsuspendOrderModel unsuspendOrderModel;

  UnsuspendOrderSuccess({required this.unsuspendOrderModel});
}

class UnsuspendOrderFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  UnsuspendOrderFailure({this.apiError, this.exception});
}

class CompleteOrderLoading extends HomeState {}

class CompleteOrderSuccess extends HomeState {
  final CompleteOrderModel completeOrderModel;

  CompleteOrderSuccess({required this.completeOrderModel});
}

class CompleteOrderFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  CompleteOrderFailure({this.apiError, this.exception});
}
