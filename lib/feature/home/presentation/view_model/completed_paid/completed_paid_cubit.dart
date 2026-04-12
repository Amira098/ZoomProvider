import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/completed_paid_model.dart';
import 'completed_paid_state.dart';
@injectable
class CompletedPaidCubit extends Cubit<CompletedPaidState> {
  final HomeDataSources repository;

  CompletedPaidCubit(this.repository) : super( CompletedPaidInitial());

  Future<void> completedPaid({
    required int orderId,
    required double amount,
    required List<int> servicesIds,
    double? materials,
  }) async {
    emit(const CompletedPaidLoading());

    try {
      final formData = FormData.fromMap({
        'amount': amount,
        'services[]': servicesIds,
        if (materials != null) 'materials': materials,
      });

      final result = await repository.completedPaid(orderId, formData);

      switch (result) {
        case SuccessResult<CompletedPaidModel>():
          emit(CompletedPaidSuccess(result.data));

        case FailureResult<CompletedPaidModel>():
          emit(
            CompletedPaidFailure(
              _extractErrorMessage(result),
            ),
          );
      }
    } catch (e) {
      emit(CompletedPaidFailure(e.toString()));
    }
  }

  String _extractErrorMessage(FailureResult<CompletedPaidModel> result) {
    final message = result.apiError?.message;

    if (message == null) {
      return result.exception.toString();
    }

    if (message is String) {
      return message.toString();
    }

    try {
      final dynamic dynamicMessage = message;
      if (dynamicMessage.en != null &&
          dynamicMessage.en.toString().trim().isNotEmpty) {
        return dynamicMessage.en.toString();
      }
      if (dynamicMessage.ar != null &&
          dynamicMessage.ar.toString().trim().isNotEmpty) {
        return dynamicMessage.ar.toString();
      }
    } catch (_) {}

    return message.toString();
  }
}