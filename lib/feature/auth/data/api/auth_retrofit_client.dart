import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/network/remote/api_constants.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/reset_password_model.dart';
import '../models/send_reset_email.dart';
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

  @POST(ApiConstants.sendResetEmail)
  @FormUrlEncoded()
  Future<SendResetEmail> sendResetEmail(
      @Field("email") String email,

      );

  @POST(ApiConstants.resetPassword)
  @FormUrlEncoded()
  Future<ResetPasswordModel> resetPassword(
      @Field("code") String code,
      @Field("email") String email,
      @Field("password") String password,
      @Field("password_confirmation") String confirmPassword,

      );




}
