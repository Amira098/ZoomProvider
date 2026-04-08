import '../../../../../core/models/api_error.dart';
import '../../../data/model/start_order_model.dart';

abstract class StartOrderState {}

class StartOrderInitial extends StartOrderState {}

class StartOrderLoading extends StartOrderState {}

class StartOrderSuccess extends StartOrderState {
  final StartOrderModel startOrderModel;

  StartOrderSuccess({required this.startOrderModel});
}

class StartOrderFailure extends StartOrderState {
  final ApiError? apiError;
  final Exception? exception;

  StartOrderFailure({this.apiError, this.exception});
}
