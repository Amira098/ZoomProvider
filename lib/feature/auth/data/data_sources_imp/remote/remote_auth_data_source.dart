import 'package:dio/dio.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../models/login_model.dart';
import '../../models/register_model.dart';
import '../../models/reset_password_model.dart';
import '../../models/send_reset_email.dart';

abstract class RemoteAuthDataSource {
  Future<Result<LoginModel>> login({
    required String phone,
    required String password,
  });

  Future<Result<RegisterModel>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<Result<SendResetEmail>> sendResetEmail({
    required String email,

  });
  Future<Result<ResetPasswordModel>> resetPassword({
    required String code,
    required String email,
    required String password,
    required String confirmPassword,
  });

}
