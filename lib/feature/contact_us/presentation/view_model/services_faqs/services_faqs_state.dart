import 'package:equatable/equatable.dart';

import '../../../data/models/services_faqs_model.dart';


abstract class ServicesFaqsState extends Equatable {
  const ServicesFaqsState();

  @override
  List<Object?> get props => [];
}

class ServicesFaqsInitial extends ServicesFaqsState {}

class ServicesFaqsLoading extends ServicesFaqsState {}

class ServicesFaqsLoaded extends ServicesFaqsState {
  final ServicesFaqsModel faqs;

  const ServicesFaqsLoaded(this.faqs);

  @override
  List<Object?> get props => [faqs];
}

class ServicesFaqsError extends ServicesFaqsState {
  final String message;

  const ServicesFaqsError(this.message);

  @override
  List<Object?> get props => [message];
}
