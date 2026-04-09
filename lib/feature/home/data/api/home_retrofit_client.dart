import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/models/custom_token_response.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../model/all_requests_model.dart';
import '../model/complete_order_model.dart';
import '../model/completed_paid_model.dart';
import '../model/home_model.dart';
import '../model/receive_order_model.dart';
import '../model/requests_details_model.dart';
import '../model/start_order_model.dart';
import '../model/suspend_order_model.dart';
import '../model/unsuspend_model.dart';
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
  @POST("orders/{order-id}/receive")
  @FormUrlEncoded()
  Future<ReceiveOrderModel> receiveOrder(
    @Path("order-id") int orderId,
    @Header("Authorization") String token,
  );
  @POST("orders/{order-id}/start")
  @FormUrlEncoded()
  Future<StartOrderModel> startOrder(
    @Path("order-id") int orderId,
    @Header("Authorization") String token,
  );
@POST("orders/{order-id}/suspend")
  @FormUrlEncoded()
  Future<SuspendOrderModel> suspendOrder(
    @Path("order-id") int orderId,
    @Field("notes") String notes,
    @Header("Authorization") String token,
  );
@POST("orders/{order-id}/unsuspend")
  @FormUrlEncoded()
  Future<UnsuspendOrderModel> unsuspendOrder(
    @Path("order-id") int orderId,
    @Header("Authorization") String token,
  );
@POST("orders/{order-id}/complete")
  @FormUrlEncoded()
  Future<CompleteOrderModel> completeOrder(
    @Path("order-id") int orderId,
    @Header("Authorization") String token,
  );
@POST("orders/{order-id}}/request-new-payment")
@FormUrlEncoded()
Future<CompletedPaidModel> completedPaid(
    @Path("order-id") int orderId,
    @Body() FormData body,
    @Header("Authorization") String token,
    );

}