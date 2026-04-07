
import '../../../../core/models/api_error.dart';
import '../../data/model/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel homeModel;

  HomeSuccess({required this.homeModel});
}

class HomeFailure extends HomeState {
  final ApiError? apiError;
  final Exception? exception;

  HomeFailure({this.apiError, this.exception});
}
