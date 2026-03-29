import 'package:injectable/injectable.dart';

import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';

import 'remote_about_us_data_source.dart';
import '../../api/about_us_retrofit_client.dart';

@Injectable(as: RemoteAboutUsDataSource)
class RemoteAboutUsDataSourceImp extends RemoteAboutUsDataSource {
  final ApiManager _apiManager;
  final AboutUsRetrofitClient _apiService;

  RemoteAboutUsDataSourceImp(
    this._apiManager,
    this._apiService,
  );

  @override
  Future<Result<GeniralModel>> AboutUs() async {
    final result = await _apiManager.execute<GeniralModel>(() async {
      final response = await _apiService.AboutUs();
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
