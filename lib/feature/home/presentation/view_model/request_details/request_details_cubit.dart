import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/requests_details_model.dart';
import 'request_details_state.dart';

@injectable
class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  final HomeDataSources homeRepo;

  RequestDetailsCubit({required this.homeRepo}) : super(RequestDetailsInitial());

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
