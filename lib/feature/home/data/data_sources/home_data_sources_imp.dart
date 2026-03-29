import 'package:injectable/injectable.dart';

import '../../../../core/network/common/api_result.dart';
import '../../../../core/network/remote/api_manager.dart';
import '../api/home_retrofit_client.dart';
import '../model/home_model.dart';
import 'home_data_sources.dart';
@Injectable( as: HomeDataSources )
class HomeDataSourcesImp implements HomeDataSources {
  final HomeRetrofitClient _apiService;
  final ApiManager _apiManager;

  HomeDataSourcesImp(this._apiService, this._apiManager);

  @override
  Future<Result<HomeModel>> getHomeData() async {
    final result = await _apiManager.execute<HomeModel>(() async {
      return await _apiService.getHomeData();
    });

    switch (result) {
      case SuccessResult<HomeModel>():
        return SuccessResult<HomeModel>(result.data);

      case FailureResult<HomeModel>():
        return FailureResult<HomeModel>(
          exception: result.exception,
          apiError: result.apiError,
        );
    }
  }
}
