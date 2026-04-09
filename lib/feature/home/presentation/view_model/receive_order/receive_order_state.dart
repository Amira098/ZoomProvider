

import '../../../../../core/models/api_error.dart';
import '../../../data/model/receive_order_model.dart';

abstract class ReceiveOrderState {}

class ReceiveOrderInitial extends ReceiveOrderState {}

class ReceiveOrderLoading extends ReceiveOrderState {}

class ReceiveOrderSuccess extends ReceiveOrderState {
  final ReceiveOrderModel receiveOrderModel;

  ReceiveOrderSuccess({required this.receiveOrderModel});
}

class ReceiveOrderFailure extends ReceiveOrderState {
  final ApiError? apiError;
  final Exception? exception;

  ReceiveOrderFailure({this.apiError, this.exception});
}
