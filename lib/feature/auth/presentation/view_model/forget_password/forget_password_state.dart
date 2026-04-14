import 'package:equatable/equatable.dart';
import '../../../../../core/models/api_error.dart';
import '../../../data/models/reset_password_model.dart';
import '../../../data/models/send_reset_email.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class SendResetEmailSuccess extends ForgetPasswordState {
  final SendResetEmail response;
  const SendResetEmailSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class SendResetEmailFailure extends ForgetPasswordState {
  final ApiError? apiError;
  final Exception? exception;

  const SendResetEmailFailure({this.apiError, this.exception});

  @override
  List<Object?> get props => [apiError, exception];
}

class ResetPasswordSuccess extends ForgetPasswordState {
  final ResetPasswordModel response;
  const ResetPasswordSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ResetPasswordFailure extends ForgetPasswordState {
  final ApiError? apiError;
  final Exception? exception;

  const ResetPasswordFailure({this.apiError, this.exception});

  @override
  List<Object?> get props => [apiError, exception];
}
