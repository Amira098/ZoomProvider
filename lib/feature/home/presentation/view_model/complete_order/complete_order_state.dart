import '../../../../../core/models/api_error.dart';
import '../../../data/model/complete_order_model.dart';

abstract class CompleteOrderState {}

class CompleteOrderInitial extends CompleteOrderState {}

class CompleteOrderLoading extends CompleteOrderState {}

class CompleteOrderSuccess extends CompleteOrderState {
  final CompleteOrderModel completeOrderModel;

  CompleteOrderSuccess({required this.completeOrderModel});
}

class CompleteOrderFailure extends CompleteOrderState {
  final ApiError? apiError;
  final Exception? exception;

  CompleteOrderFailure({this.apiError, this.exception});
}
