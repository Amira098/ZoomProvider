import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/suspend_order_model.dart';
import 'suspend_order_state.dart';

@injectable
class SuspendOrderCubit extends Cubit<SuspendOrderState> {
  final HomeDataSources homeRepo;

  SuspendOrderCubit({required this.homeRepo}) : super(SuspendOrderInitial());

  Future<void> suspendOrder(int orderId, String notes) async {
    emit(SuspendOrderLoading());

    final result = await homeRepo.suspendOrder(orderId, notes);

    switch (result) {
      case SuccessResult<SuspendOrderModel>():
        emit(SuspendOrderSuccess(suspendOrderModel: result.data));
        break;

      case FailureResult<SuspendOrderModel>():
        emit(
          SuspendOrderFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
