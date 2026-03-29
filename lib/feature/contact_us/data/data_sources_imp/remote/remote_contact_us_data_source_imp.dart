import 'package:injectable/injectable.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../../../core/network/remote/api_manager.dart';

import '../../../../../core/utils/app_shared_preference.dart';
import '../../api/contact_us_retrofit_client.dart';
import '../../models/contact_us.dart';
import '../../models/services_faqs_model.dart';
import 'remote_contact_us_data_source.dart';


@Injectable(as: RemoteContactUsDataSource)
class RemoteContactUsDataSourceImp extends RemoteContactUsDataSource {
  final ApiManager _apiManager;
  final ContactUsRetrofitClient _apiService;

  RemoteContactUsDataSourceImp(this._apiManager, this._apiService);

  @override
  Future<Result<ContactModel>> contactUs({
    required String subject,
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    final result = await _apiManager.execute<ContactModel>(() async {
      final response = await _apiService.contactUs(
        subject,
        name,
        email,
        phone,
        message,
      );
      return response;
    });

    switch (result) {
      case SuccessResult<ContactModel>():
        return SuccessResult<ContactModel>(result.data);
      case FailureResult<ContactModel>():
        return FailureResult<ContactModel>(
          exception: result.exception,
          apiError: result.apiError,
        );
    }
  }

  @override
  Future<Result<ServicesFaqsModel>> servicesFaqs() async{
    final result = await _apiManager.execute<ServicesFaqsModel>(() async {
      return await _apiService.servicesFaqs();
    });
    switch (result) {
      case SuccessResult<ServicesFaqsModel>():
        return SuccessResult(result.data);
      case FailureResult<ServicesFaqsModel>():
        return FailureResult(
          exception: result.exception,
          apiError: result.apiError,
        );
    }
  }





}
