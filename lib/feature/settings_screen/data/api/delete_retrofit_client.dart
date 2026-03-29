import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/network/remote/api_constants.dart';
import '../model/delete_model.dart';
part 'delete_retrofit_client.g.dart';
@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DeleteRetrofitClient {
  @factoryMethod
  factory DeleteRetrofitClient(Dio dio) = _DeleteRetrofitClient;

  @DELETE(ApiConstants.deleteAccount)
  @FormUrlEncoded()
  Future<DeleteModel> deleteAccount(
      @Header("Authorization") String authorization,
      );
}
