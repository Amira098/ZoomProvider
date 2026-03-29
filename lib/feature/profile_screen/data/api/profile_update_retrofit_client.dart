import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/profile_update_model.dart';

part 'profile_update_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileUpdateRetrofitClient {
  @factoryMethod
  factory ProfileUpdateRetrofitClient(Dio dio) = _ProfileUpdateRetrofitClient;

  @POST(ApiConstants.profileUpdate)
  Future<ProfileUpdateModel> profileUpdate(
      @Body() FormData body,
      @Header('Authorization') String token,
      );
}
