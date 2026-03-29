import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../data/usecase/privacy_usecase.dart';


part 'privacy_state.dart';

@injectable
class PrivacyCubit extends Cubit<PrivacyState> {
  final PrivacyUseCase _privacyUseCase;

  PrivacyCubit(this._privacyUseCase) : super(PrivacyInitial());

  Future<void> getPrivacyPolicy() async {
    emit(PrivacyLoading());

    try {
      final result = await _privacyUseCase.execute();

      switch (result) {
        case SuccessResult<GeniralModel>():
          emit(PrivacySuccess(result.data));
        case FailureResult<GeniralModel>():
          emit(PrivacyFailure(result.exception.toString()?? LocaleKeys.error.tr()));
      }
    } catch (e) {
      emit(PrivacyFailure(LocaleKeys.error.tr()));
    }
  }
}
