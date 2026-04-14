import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources_imp/remote/remote_auth_data_source.dart';
import '../../../data/models/reset_password_model.dart';
import '../../../data/models/send_reset_email.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final RemoteAuthDataSource _remoteAuthDataSource;

  ForgetPasswordCubit(this._remoteAuthDataSource) : super(ForgetPasswordInitial());

  Future<void> sendResetEmail({required String email}) async {
    emit(ForgetPasswordLoading());

    final result = await _remoteAuthDataSource.sendResetEmail(email: email);

    if (result is SuccessResult<SendResetEmail>) {
      emit(SendResetEmailSuccess(result.data));
    } else if (result is FailureResult<SendResetEmail>) {
      emit(SendResetEmailFailure(
        apiError: result.apiError,
        exception: result.exception,
      ));
    }
  }

  Future<void> resetPassword({
    required String code,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ForgetPasswordLoading());

    final result = await _remoteAuthDataSource.resetPassword(
      code: code,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (result is SuccessResult<ResetPasswordModel>) {
      emit(ResetPasswordSuccess(result.data));
    } else if (result is FailureResult<ResetPasswordModel>) {
      emit(ResetPasswordFailure(
        apiError: result.apiError,
        exception: result.exception,
      ));
    }
  }
}
