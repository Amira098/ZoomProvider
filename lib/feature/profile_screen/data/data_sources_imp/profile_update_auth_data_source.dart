import 'package:dio/dio.dart';

import '../../../../../core/network/common/api_result.dart';
import '../model/profile_update_model.dart';


abstract class RemoteProfileUpdateDataSource {

  Future<Result<ProfileUpdateModel>> profileUpdate({
    required String name,
    required String phone,
    required String email,
    required String image,
    required String address,

  });
}
