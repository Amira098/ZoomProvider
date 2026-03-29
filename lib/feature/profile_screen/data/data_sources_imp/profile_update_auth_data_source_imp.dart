// feature/profile_screen/data/data_sources_imp/remote_profile_update_data_source_imp.dart

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:zoom_provider/feature/profile_screen/data/data_sources_imp/profile_update_auth_data_source.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';
import '../../../../../core/utils/app_shared_preference.dart';
import '../api/profile_update_retrofit_client.dart';
import '../model/profile_update_model.dart';
@Injectable(as: RemoteProfileUpdateDataSource)
class RemoteProfileUpdateDataSourceImp extends RemoteProfileUpdateDataSource {
  final ApiManager _apiManager;
  final ProfileUpdateRetrofitClient _apiService;

  RemoteProfileUpdateDataSourceImp(
      this._apiManager,
      this._apiService,
      );

  bool _isLocalFile(String path) {
    if (path.isEmpty) return false;
    return !(path.startsWith('http://') || path.startsWith('https://'));
  }

  Future<MultipartFile?> _fileToMultipartOrNull(String path) async {
    if (!_isLocalFile(path)) return null;
    final file = File(path);
    if (!await file.exists()) return null;

    final fileName = p.basename(path);
    final mime = lookupMimeType(path) ?? 'image/jpeg';
    final mediaType = MediaType.parse(mime);

    return MultipartFile.fromFile(
      path,
      filename: fileName,
      contentType: mediaType,
    );
  }

  @override
  Future<Result<ProfileUpdateModel>> profileUpdate({
    required String name,
    required String phone,
    required String email,
    required String image,
    required String address,
  }) async {
    final result = await _apiManager.execute<ProfileUpdateModel>(() async {
      final multipartImage = await _fileToMultipartOrNull(image);
      final token = await SharedPreferencesUtils.getString(AppValues.token);
      final auth = 'Bearer $token';
      final formData = FormData.fromMap({
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        if (multipartImage != null) 'image': multipartImage,
      });

      return await _apiService.profileUpdate(formData, auth);
    });

    if (result is SuccessResult<ProfileUpdateModel>) {
      final profileData = result.data;

      if (profileData != null) {

        await SharedPreferencesUtils.saveData(
          key: AppValues.user,
          value: jsonEncode(profileData.toJson()),
        );
        await SharedPreferencesUtils.saveData(
          key: AppValues.loggedIn,
          value: true,
        );
      }

      return SuccessResult(profileData);
    } else if (result is FailureResult<ProfileUpdateModel>) {
      return FailureResult(
        exception: result.exception,
        apiError: result.apiError,
      );
    } else {
      return FailureResult(
        exception: Exception('Unknown result type'),
      );
    }
  }
}
