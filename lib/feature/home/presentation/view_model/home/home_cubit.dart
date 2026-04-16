import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
}
