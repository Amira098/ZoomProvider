import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources_imp/remote/remote_contact_us_data_source.dart';
import '../../../data/models/services_faqs_model.dart';
import 'services_faqs_state.dart';
@injectable
class ServicesFaqsCubit extends Cubit<ServicesFaqsState> {
  final RemoteContactUsDataSource _remoteDataSource;

  ServicesFaqsCubit(this._remoteDataSource) : super(ServicesFaqsInitial());

  Future<void> fetchFaqs() async {
    emit(ServicesFaqsLoading());

    final result = await _remoteDataSource.servicesFaqs();

    switch (result) {
      case SuccessResult<ServicesFaqsModel>():
        emit(ServicesFaqsLoaded(result.data));
        break;
      case FailureResult<ServicesFaqsModel>():
        emit(ServicesFaqsError(result.apiError?.message.toString() ?? 'Something went wrong'));
        break;
    }
  }
}
