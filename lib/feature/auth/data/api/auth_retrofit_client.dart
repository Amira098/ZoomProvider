import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(ApiConstants.login)
  @FormUrlEncoded()
  Future<LoginModel> login(
      @Field("phone") String phone,
      @Field("password") String password,

      );

  @POST(ApiConstants.register)
  @FormUrlEncoded()
  Future<RegisterModel> register(
      @Field("name") String name,
      @Field("phone") String phone,
      @Field("email") String email,
      @Field("password") String password,
      @Field("password_confirmation") String confirmPassword,

  );




}
