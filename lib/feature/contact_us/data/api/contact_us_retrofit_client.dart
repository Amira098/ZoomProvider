import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../models/contact_requests_model.dart';
import '../models/contact_us.dart';
import '../models/services_faqs_model.dart';
part 'contact_us_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ContactUsRetrofitClient {
  @factoryMethod
  factory ContactUsRetrofitClient(Dio dio) = _ContactUsRetrofitClient;

  @POST(ApiConstants.contactUs)
  @FormUrlEncoded()
  Future<ContactModel> contactUs(
      @Field('subject') String subject,
      @Field('name') String name,
      @Field('email') String email,
      @Field('phone') String phone,
      @Field('message') String message,
      );
  @GET(ApiConstants.servicesFaqs)
  @FormUrlEncoded()
  Future<ServicesFaqsModel> servicesFaqs();
  @GET(ApiConstants.contact)
  Future<ContactRequestsModel> contactRequests();
}
