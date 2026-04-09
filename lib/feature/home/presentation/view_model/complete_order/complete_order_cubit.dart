import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/complete_order_model.dart';
import 'complete_order_state.dart';

@injectable
class CompleteOrderCubit extends Cubit<CompleteOrderState> {
  final HomeDataSources homeRepo;

  CompleteOrderCubit({required this.homeRepo}) : super(CompleteOrderInitial());

  Future<void> completeOrder(
    int orderId, {
    String? notes,
    String? amount,
    String? paymentStatus,
    String? completionType,
  }) async {
    emit(CompleteOrderLoading());

    final result = await homeRepo.completeOrder(
      orderId,
      notes: notes,
      amount: amount,
      paymentStatus: paymentStatus,
      completionType: completionType,
    );

    switch (result) {
      case SuccessResult<CompleteOrderModel>():
        emit(CompleteOrderSuccess(completeOrderModel: result.data));
        break;

      case FailureResult<CompleteOrderModel>():
        emit(
          CompleteOrderFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
