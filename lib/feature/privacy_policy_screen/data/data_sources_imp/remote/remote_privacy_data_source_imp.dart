import 'package:injectable/injectable.dart';

import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';

import 'remote_privacy_data_source.dart';
import '../../api/privacy_retrofit_client.dart';

@Injectable(as: RemotePrivacyDataSource)
class RemotePrivacyDataSourceImp extends RemotePrivacyDataSource {
  final ApiManager _apiManager;
  final PrivacyRetrofitClient _apiService;

  RemotePrivacyDataSourceImp(
    this._apiManager,
    this._apiService,
  );

  @override
  Future<Result<GeniralModel>> privacy() async {
    final result = await _apiManager.execute<GeniralModel>(() async {
      final response = await _apiService.privacy();
      return response;
    });
    switch (result) {
      case SuccessResult<GeniralModel>():
        return SuccessResult<GeniralModel>(result.data);
      case FailureResult<GeniralModel>():
        return FailureResult<GeniralModel>(
          exception: result.exception,
          apiError: result.apiError,
        );
    }
  }

}
// ex
// @override
// Future<Result<ModelResponseEntity>> function() async {
//   final result = await _apiManager.execute<ModelResponseDto>(() async {
//     final response =
//         await _apiService.function(ModelRequestDto());
//     return response;
//   });
//   switch (result) {
//     case SuccessResult<ModelResponseDto>():
//       return SuccessResult<ModelResponseEntity>(result.data.toEntity());
//     case FailureResult<ModelResponseDto>():
//       return FailureResult<ModelResponseEntity>(result.exception);
//   }
// }
