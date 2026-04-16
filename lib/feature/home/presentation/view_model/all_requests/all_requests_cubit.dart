import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/all_requests_model.dart';
import 'all_requests_state.dart';

@injectable
class AllRequestsCubit extends Cubit<AllRequestsState> {
  final HomeDataSources homeRepo;

  AllRequestsCubit({required this.homeRepo}) : super(AllRequestsInitial());

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
}
