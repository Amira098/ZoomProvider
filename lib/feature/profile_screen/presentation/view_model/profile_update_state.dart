import 'package:equatable/equatable.dart';

import '../../../../core/models/api_error.dart';
import '../../data/model/profile_update_model.dart';

abstract class ProfileUpdateState extends Equatable {
  const ProfileUpdateState();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateSuccess extends ProfileUpdateState {
  final ProfileUpdateModel profileData;
  const ProfileUpdateSuccess(this.profileData);

  @override
  List<Object?> get props => [profileData];
}

class ProfileUpdateFailure extends ProfileUpdateState {
  final    ApiError? apiError;
  final Exception? exception;
  const ProfileUpdateFailure(this.apiError,this.exception);

  @override
  List<Object?> get props => [apiError, exception];
}
