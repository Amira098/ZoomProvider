import '../../../../../core/models/api_error.dart';
import '../../../data/model/suspend_order_model.dart';

abstract class SuspendOrderState {}

class SuspendOrderInitial extends SuspendOrderState {}

class SuspendOrderLoading extends SuspendOrderState {}

class SuspendOrderSuccess extends SuspendOrderState {
  final SuspendOrderModel suspendOrderModel;

  SuspendOrderSuccess({required this.suspendOrderModel});
}

class SuspendOrderFailure extends SuspendOrderState {
  final ApiError? apiError;
  final Exception? exception;

  SuspendOrderFailure({this.apiError, this.exception});
}
