part of 'about_us_cubit.dart';

abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsSuccess extends AboutUsState {
  final GeniralModel data;
  AboutUsSuccess(this.data);
}

class AboutUsFailure extends AboutUsState {
  final String message;
  AboutUsFailure(this.message);
}
