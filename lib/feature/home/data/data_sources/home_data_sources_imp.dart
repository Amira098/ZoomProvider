import 'package:injectable/injectable.dart';
import 'package:zoom_provider/feature/home/data/model/all_requests_model.dart';
import 'package:zoom_provider/feature/home/data/model/requests_details_model.dart';

import '../../../../core/constants/app_values.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/network/remote/api_manager.dart';
import '../../../../core/utils/app_shared_preference.dart';
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
      final token = await SharedPreferencesUtils.getString(AppValues.token);
      final auth = 'Bearer $token';
      return await _apiService.getHomeData(auth);
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

  @override
  Future<Result<AllRequestsModel>> getAllRequests()async {
    final result = await _apiManager.execute<AllRequestsModel>(() async {
      final token = await SharedPreferencesUtils.getString(AppValues.token);
      final auth = 'Bearer $token';
      return await _apiService.getAllRequests(auth);
    });

    switch (result) {
      case SuccessResult<AllRequestsModel>():
        return SuccessResult<AllRequestsModel>(result.data);

      case FailureResult<AllRequestsModel>():
        return FailureResult<AllRequestsModel>(
          exception: result.exception,
          apiError: result.apiError,
        );
    }
  }

  @override
  Future<Result<RequestsDetailsModel>> getRequestsDetails(int requestsId)async {
    final result = await _apiManager.execute<RequestsDetailsModel>(() async {
      final token = await SharedPreferencesUtils.getString(AppValues.token);
      final auth = 'Bearer $token';
      return await _apiService.getRequestsDetails(requestsId,auth);
    });

    switch (result) {
      case SuccessResult<RequestsDetailsModel>():
        return SuccessResult<RequestsDetailsModel>(result.data);

      case FailureResult<RequestsDetailsModel>():
        return FailureResult<RequestsDetailsModel>(
          exception: result.exception,
          apiError: result.apiError,
        );
    }
  }
}
