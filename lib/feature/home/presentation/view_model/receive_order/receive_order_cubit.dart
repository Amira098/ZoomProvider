import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../data/data_sources/home_data_sources.dart';
import '../../data/model/receive_order_model.dart';
import 'receive_order_state.dart';

@injectable
class ReceiveOrderCubit extends Cubit<ReceiveOrderState> {
  final HomeDataSources homeRepo;

  ReceiveOrderCubit({required this.homeRepo}) : super(ReceiveOrderInitial());

  Future<void> receiveOrder(int orderId) async {
    emit(ReceiveOrderLoading());

    final result = await homeRepo.receiveOrder(orderId);

    switch (result) {
      case SuccessResult<ReceiveOrderModel>():
        emit(ReceiveOrderSuccess(receiveOrderModel: result.data));
        break;

      case FailureResult<ReceiveOrderModel>():
        emit(
          ReceiveOrderFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
