import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/suspend_with_goods_returned.dart';
import 'suspend_with_goods_returned_state.dart';

@injectable
class SuspendWithGoodsReturnedCubit extends Cubit<SuspendWithGoodsReturnedState> {
  final HomeDataSources homeRepo;

  SuspendWithGoodsReturnedCubit({required this.homeRepo}) : super(SuspendWithGoodsReturnedInitial());

  Future<void> suspendWithGoodsReturned(int orderId, FormData body) async {
    emit(SuspendWithGoodsReturnedLoading());

    final result = await homeRepo.suspendWithGoodsReturned(orderId, body);

    switch (result) {
      case SuccessResult<SuspendWithGoodsReturnedModel>():
        emit(SuspendWithGoodsReturnedSuccess(suspendWithGoodsReturnedModel: result.data));
        break;

      case FailureResult<SuspendWithGoodsReturnedModel>():
        emit(
          SuspendWithGoodsReturnedFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
