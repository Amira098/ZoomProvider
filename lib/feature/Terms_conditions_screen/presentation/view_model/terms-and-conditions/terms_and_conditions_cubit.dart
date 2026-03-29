import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:zoom_provider/feature/Terms_conditions_screen/presentation/view_model/terms-and-conditions/terms_and_conditions_state.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/usecase/terms-and-conditions_usecase.dart';



@injectable
class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  final termsAndConditionsUseCase _termsAndConditionsUseCase;
  TermsAndConditionsCubit(this._termsAndConditionsUseCase) : super(TermsAndConditionsInitial());
  Future<void> gettermsAndConditions() async {
    emit(TermsAndConditionsLoading());

    try {
      final result = await _termsAndConditionsUseCase.execute();

      switch (result) {
        case SuccessResult<GeniralModel>():
          emit(TermsAndConditionsSuccess(result.data));
        case FailureResult<GeniralModel>():
          emit(TermsAndConditionsFailure(result.exception.toString()?? LocaleKeys.error.tr()));
      }
    } catch (e) {
      emit(TermsAndConditionsFailure(LocaleKeys.error.tr()));
    }
  }
}
