import 'package:dio/dio.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../models/login_model.dart';
import '../../models/register_model.dart';

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
}
