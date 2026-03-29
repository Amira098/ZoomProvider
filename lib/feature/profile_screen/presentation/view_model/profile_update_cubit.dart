import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/common/api_result.dart';
import '../../data/data_sources_imp/profile_update_auth_data_source.dart';

import '../../data/model/profile_update_model.dart';
import 'profile_update_state.dart';
@injectable
class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  final RemoteProfileUpdateDataSource _updateProfile;

  ProfileUpdateCubit(this._updateProfile) : super(ProfileUpdateInitial());

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    required String image,
    required String address,
  }) async {
    emit(ProfileUpdateLoading());

    final result = await _updateProfile.profileUpdate(
      name: name,
      phone: phone,
      email: email,
      image: image,
      address: address,
    );

    if (result is SuccessResult<ProfileUpdateModel>) {
      emit(ProfileUpdateSuccess(result.data));
    } else if (result is FailureResult<ProfileUpdateModel>) {
      emit(ProfileUpdateFailure(
       result.apiError,
       result.exception,
      ));
    }
  }
}
