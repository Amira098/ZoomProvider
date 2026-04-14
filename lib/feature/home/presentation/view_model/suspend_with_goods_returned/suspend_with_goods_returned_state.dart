import '../../../../../core/network/common/api_result.dart';
import '../../../data/model/suspend_with_goods_returned.dart';

abstract class SuspendWithGoodsReturnedState {}

class SuspendWithGoodsReturnedInitial extends SuspendWithGoodsReturnedState {}

class SuspendWithGoodsReturnedLoading extends SuspendWithGoodsReturnedState {}

class SuspendWithGoodsReturnedSuccess extends SuspendWithGoodsReturnedState {
  final SuspendWithGoodsReturnedModel suspendWithGoodsReturnedModel;

  SuspendWithGoodsReturnedSuccess({required this.suspendWithGoodsReturnedModel});
}

class SuspendWithGoodsReturnedFailure extends SuspendWithGoodsReturnedState {
  final ApiError? apiError;
  final Exception? exception;

  SuspendWithGoodsReturnedFailure({this.apiError, this.exception});
}
