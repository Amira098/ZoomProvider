import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../data/data_sources/home_data_sources.dart';
import '../../data/model/unsuspend_model.dart';
import 'unsuspend_order_state.dart';

@injectable
class UnsuspendOrderCubit extends Cubit<UnsuspendOrderState> {
  final HomeDataSources homeRepo;

  UnsuspendOrderCubit({required this.homeRepo}) : super(UnsuspendOrderInitial());

  Future<void> unsuspendOrder(int orderId) async {
    emit(UnsuspendOrderLoading());

    final result = await homeRepo.unsuspendOrder(orderId);

    switch (result) {
      case SuccessResult<UnsuspendOrderModel>():
        emit(UnsuspendOrderSuccess(unsuspendOrderModel: result.data));
        break;

      case FailureResult<UnsuspendOrderModel>():
        emit(
          UnsuspendOrderFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
