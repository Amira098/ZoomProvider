import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';
import '../../../../../core/utils/app_shared_preference.dart';
import '../../api/auth_retrofit_client.dart';
import '../../models/login_model.dart';
import '../../models/register_model.dart';
import 'remote_auth_data_source.dart';

@Injectable(as: RemoteAuthDataSource)
class RemoteAuthDataSourceImp extends RemoteAuthDataSource {
  final ApiManager _apiManager;
  final AuthRetrofitClient _apiService;

  RemoteAuthDataSourceImp(
      this._apiManager,
      this._apiService,
      );

  @override
  Future<Result<LoginModel>> login({
    required String phone,
    required String password,
  }) async {
    final result = await _apiManager.execute<LoginModel>(() async {
      return await _apiService.login(phone, password);
    });

    if (result is SuccessResult<LoginModel>) {
      final data = result.data;
      final token = result.data.token;
      if (token != null && token.isNotEmpty) {
        await SharedPreferencesUtils.saveData(
          key: AppValues.token,
          value: token,
        );
      }
      if (data.user != null) {
        await SharedPreferencesUtils.saveData(
          key: AppValues.user,
          value: jsonEncode(data.user!.toJson()),
        );
        await SharedPreferencesUtils.saveData(
          key: AppValues.loggedIn,
          value: true,
        );
      }




      return SuccessResult<LoginModel>(result.data);
    } else if (result is FailureResult<LoginModel>) {
      return FailureResult<LoginModel>(
        exception: result.exception,
        apiError: result.apiError,
      );
    } else {
      return FailureResult<LoginModel>(
        exception: Exception('Unknown result type'),
      );
    }
  }

  @override
  Future<Result<RegisterModel>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,

  }) async {
    final result = await _apiManager.execute<RegisterModel>(() async {
      return await _apiService.register(name, phone, email, password, confirmPassword);
    });

    if (result is SuccessResult<RegisterModel>) {
      final data = result.data;
      final token = result.data.token;
      if (token != null && token.isNotEmpty) {
        await SharedPreferencesUtils.saveData(
          key: AppValues.token,
          value: token,
        );
      }

      if (data.user != null) {
        await SharedPreferencesUtils.saveData(
          key: AppValues.user,
          value: jsonEncode(data.user!.toJson()),
        );
        await SharedPreferencesUtils.saveData(
          key: AppValues.loggedIn,
          value: true,
        );
      }

      return SuccessResult<RegisterModel>(result.data);
    } else if (result is FailureResult<RegisterModel>) {
      return FailureResult<RegisterModel>(
        exception: result.exception,
        apiError: result.apiError,
      );
    } else {
      return FailureResult<RegisterModel>(
        exception: Exception('Unknown result type'),
      );
    }
  }
}
