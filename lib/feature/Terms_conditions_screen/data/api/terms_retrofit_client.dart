import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/models/drawer_model.dart';
import '../../../../core/network/remote/api_constants.dart';
part 'terms_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class TermsRetrofitClient {
  @factoryMethod
  factory TermsRetrofitClient(Dio dio) = _TermsRetrofitClient;

  @GET(ApiConstants.termsAndConditions)
  Future<GeniralModel> termsAndConditions();




}
