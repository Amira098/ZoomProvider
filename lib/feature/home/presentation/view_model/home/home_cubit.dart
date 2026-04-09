import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:zoom_provider/feature/home/data/model/all_requests_model.dart';
import 'package:zoom_provider/feature/home/data/model/requests_details_model.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/home_model.dart';

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
}
