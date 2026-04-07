import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/models/custom_token_response.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/all_requests_model.dart';
import '../model/home_model.dart';
import '../model/requests_details_model.dart';
part 'home_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeRetrofitClient {
  @factoryMethod
  factory HomeRetrofitClient(Dio dio) = _HomeRetrofitClient;

    @GET(ApiConstants.home)
  @FormUrlEncoded()
  Future<HomeModel> getHomeData(
@Header("Authorization") String token,
  );

    @GET(ApiConstants.requests)
  @FormUrlEncoded()
  Future<AllRequestsModel> getAllRequests(
  @Header("Authorization") String token,
  );

    @GET("orders/{order}")
  @FormUrlEncoded()
  Future<RequestsDetailsModel> getRequestsDetails(
        @Path("order") int requestsId,
       @Header("Authorization") String token,
  );

}