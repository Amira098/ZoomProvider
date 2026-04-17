import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/create_reservation_model.dart';
import 'create_reservation_state.dart';

@injectable
class CreateReservationCubit extends Cubit<CreateReservationState> {
  final HomeDataSources homeRepo;

  CreateReservationCubit({required this.homeRepo}) : super(CreateReservationInitial());

  Future<void> createReservation(int patientId, String date, String time) async {
    emit(CreateReservationLoading());

    final result = await homeRepo.createReservation(patientId, date, time);

    switch (result) {
      case SuccessResult<CreateReservationModel>():
        emit(CreateReservationSuccess(createReservationModel: result.data));
        break;

      case FailureResult<CreateReservationModel>():
        emit(
          CreateReservationFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
