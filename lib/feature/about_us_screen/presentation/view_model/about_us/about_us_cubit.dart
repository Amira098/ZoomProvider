import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../data/usecase/about_us_usecase.dart';


part 'about_us_state.dart';

@injectable
class AboutUsCubit extends Cubit<AboutUsState> {
  final AboutUsUseCase _aboutUsUseCase;

  AboutUsCubit(this._aboutUsUseCase) : super(AboutUsInitial());

  Future<void> getAboutUs() async {
    emit(AboutUsLoading());

    try {
      final result = await _aboutUsUseCase.execute();

      switch (result) {
        case SuccessResult<GeniralModel>():
          emit(AboutUsSuccess(result.data));
        case FailureResult<GeniralModel>():
          emit(AboutUsFailure(result.exception.toString()));
      }
    } catch (e) {
      emit(AboutUsFailure(LocaleKeys.error.tr()));
    }
  }
}
