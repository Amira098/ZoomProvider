import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/completed_paid_model.dart';
import 'completed_paid_state.dart';

@injectable
class CompletedPaidCubit extends Cubit<CompletedPaidState> {
  final HomeDataSources repository;

  CompletedPaidCubit(this.repository) : super(const CompletedPaidInitial());

  Future<void> completedPaid({
    required int orderId,
    required double amount,
    required List<int> servicesIds,
    double? materials,
    required XFile depositReceipt,
  }) async {
    emit(const CompletedPaidLoading());

    try {
      final formData = FormData.fromMap({
        'amount': amount,
        'services[]': servicesIds,
        if (materials != null) 'materials': materials,
        'deposit_receipt': await MultipartFile.fromFile(
          depositReceipt.path,
          filename: depositReceipt.name,
        ),
      });

      final result = await repository.completedPaid(orderId, formData);

      switch (result) {
        case SuccessResult<CompletedPaidModel>():
          emit(CompletedPaidSuccess(result.data));
          break;

        case FailureResult<CompletedPaidModel>():
          emit(CompletedPaidFailure(_extractErrorMessage(result)));
          break;
      }
    } catch (e) {
      emit(CompletedPaidFailure(e.toString()));
    }
  }

  String _extractErrorMessage(FailureResult<CompletedPaidModel> result) {
    final dynamic message = result.apiError?.message;

    if (message == null) {
      return result.exception?.toString() ?? 'Something went wrong';
    }

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    if (message is Map<String, dynamic>) {
      final en = message['en']?.toString().trim();
      final ar = message['ar']?.toString().trim();

      if (en != null && en.isNotEmpty) return en;
      if (ar != null && ar.isNotEmpty) return ar;
    }

    try {
      final en = message.en?.toString().trim();
      final ar = message.ar?.toString().trim();

      if (en != null && en.isNotEmpty) return en;
      if (ar != null && ar.isNotEmpty) return ar;
    } catch (_) {}

    return message.toString();
  }
}