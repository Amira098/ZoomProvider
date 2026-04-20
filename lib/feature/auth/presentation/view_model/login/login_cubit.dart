import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/serves/one_signal_service.dart';
import '../../../data/data_sources_imp/remote/remote_auth_data_source.dart';
import '../../../data/models/login_model.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final RemoteAuthDataSource _remoteAuthDataSource;
  final OneSignalService _oneSignalService;

  LoginCubit(
      this._remoteAuthDataSource,
      this._oneSignalService,
      ) : super(LoginInitial());

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await _remoteAuthDataSource.login(
      phone: phone,
      password: password,
    );

    if (result is SuccessResult<LoginModel>) {
      final loginModel = result.data;
      final userId = loginModel.user?.id;

      if (userId != null) {
        try {
          await _oneSignalService.loginUser(userId.toString() ,);
        } catch (_) {}
      }

      emit(LoginSuccess(loginModel));
    } else if (result is FailureResult<LoginModel>) {
      emit(
        LoginFailure(
          apiError: result.apiError,
          exception: result.exception,
        ),
      );
    }
  }
}