import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/get_received_requests_model.dart';
import 'get_received_requests_state.dart';

@injectable
class GetReceivedRequestsCubit extends Cubit<GetReceivedRequestsState> {
  final HomeDataSources homeRepo;

  GetReceivedRequestsCubit({required this.homeRepo}) : super(GetReceivedRequestsInitial());

  Future<void> getReceivedRequests() async {
    emit(GetReceivedRequestsLoading());

    final result = await homeRepo.getReceivedRequests();

    switch (result) {
      case SuccessResult<GetReceivedRequestsModel>():
        emit(GetReceivedRequestsSuccess(receivedRequestsModel: result.data));
        break;

      case FailureResult<GetReceivedRequestsModel>():
        emit(
          GetReceivedRequestsFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
