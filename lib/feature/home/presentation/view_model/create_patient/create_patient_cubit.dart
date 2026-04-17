import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/create_patient_model.dart';
import 'create_patient_state.dart';

@injectable
class CreatePatientCubit extends Cubit<CreatePatientState> {
  final HomeDataSources homeRepo;

  CreatePatientCubit({required this.homeRepo}) : super(CreatePatientInitial());

  Future<void> createPatient(String name, String phone) async {
    emit(CreatePatientLoading());

    final result = await homeRepo.createPatient(name, phone);

    switch (result) {
      case SuccessResult<CreatePatientModel>():
        emit(CreatePatientSuccess(createPatientModel: result.data));
        break;

      case FailureResult<CreatePatientModel>():
        emit(
          CreatePatientFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
