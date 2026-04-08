import '../../../../../core/models/api_error.dart';
import '../../../data/model/unsuspend_model.dart';

abstract class UnsuspendOrderState {}

class UnsuspendOrderInitial extends UnsuspendOrderState {}

class UnsuspendOrderLoading extends UnsuspendOrderState {}

class UnsuspendOrderSuccess extends UnsuspendOrderState {
  final UnsuspendOrderModel unsuspendOrderModel;

  UnsuspendOrderSuccess({required this.unsuspendOrderModel});
}

class UnsuspendOrderFailure extends UnsuspendOrderState {
  final ApiError? apiError;
  final Exception? exception;

  UnsuspendOrderFailure({this.apiError, this.exception});
}
