import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/start_order_model.dart';
import 'start_order_state.dart';

@injectable
class StartOrderCubit extends Cubit<StartOrderState> {
  final HomeDataSources homeRepo;

  StartOrderCubit({required this.homeRepo}) : super(StartOrderInitial());

  Future<void> startOrder(int orderId) async {
    emit(StartOrderLoading());

    final result = await homeRepo.startOrder(orderId);

    switch (result) {
      case SuccessResult<StartOrderModel>():
        emit(StartOrderSuccess(startOrderModel: result.data));
        break;

      case FailureResult<StartOrderModel>():
        emit(
          StartOrderFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
