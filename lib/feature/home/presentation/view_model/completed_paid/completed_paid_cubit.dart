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
    required List<XFile> depositReceipts,
    required String depositAccountType,
  }) async {
    emit(const CompletedPaidLoading());

    try {
      final formData = FormData();

      formData.fields.add(
        MapEntry('amount', amount.toString()),
      );

      for (final serviceId in servicesIds) {
        formData.fields.add(
          MapEntry('services[]', serviceId.toString()),
        );
      }

      if (materials != null) {
        formData.fields.add(
          MapEntry('materials', materials.toString()),
        );
      }

      formData.fields.add(
        MapEntry('deposit_account_type', depositAccountType),
      );

      for (final receipt in depositReceipts) {
        formData.files.add(
          MapEntry(
            'deposit_receipts[]',
            await MultipartFile.fromFile(
              receipt.path,
              filename: receipt.name,
            ),
          ),
        );
      }

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