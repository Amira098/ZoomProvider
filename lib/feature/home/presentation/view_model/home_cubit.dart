import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:zoom_provider/feature/home/data/model/all_requests_model.dart';
import 'package:zoom_provider/feature/home/data/model/complete_order_model.dart';
import 'package:zoom_provider/feature/home/data/model/receive_order_model.dart';
import 'package:zoom_provider/feature/home/data/model/requests_details_model.dart';
import 'package:zoom_provider/feature/home/data/model/start_order_model.dart';
import 'package:zoom_provider/feature/home/data/model/suspend_order_model.dart';
import 'package:zoom_provider/feature/home/data/model/unsuspend_model.dart';
import '../../../../core/network/common/api_result.dart';
import '../../data/data_sources/home_data_sources.dart';
import '../../data/model/home_model.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeDataSources homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());

    final result = await homeRepo.getHomeData();

    switch (result) {
      case SuccessResult<HomeModel>():
        emit(HomeSuccess(homeModel: result.data));
        break;

      case FailureResult<HomeModel>():
        emit(
          HomeFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }

  Future<void> getAllRequests() async {
    emit(AllRequestsLoading());

    final result = await homeRepo.getAllRequests();

    switch (result) {
      case SuccessResult<AllRequestsModel>():
        emit(AllRequestsSuccess(allRequestsModel: result.data));
        break;

      case FailureResult<AllRequestsModel>():
        emit(
          AllRequestsFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }

  Future<void> getRequestsDetails(int requestsId) async {
    emit(RequestDetailsLoading());

    final result = await homeRepo.getRequestsDetails(requestsId);

    switch (result) {
      case SuccessResult<RequestsDetailsModel>():
        emit(RequestDetailsSuccess(requestsDetailsModel: result.data));
        break;

      case FailureResult<RequestsDetailsModel>():
        emit(
          RequestDetailsFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }

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

  Future<void> completeOrder(int orderId) async {
    emit(CompleteOrderLoading());

    final result = await homeRepo.completeOrder(orderId);

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
