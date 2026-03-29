
import '../../../../../core/models/drawer_model.dart';


abstract class TermsAndConditionsState {
  const TermsAndConditionsState();
}

class TermsAndConditionsInitial extends TermsAndConditionsState {}

class TermsAndConditionsLoading extends TermsAndConditionsState {}

class TermsAndConditionsSuccess extends TermsAndConditionsState {
  final GeniralModel data;
  TermsAndConditionsSuccess(this.data);
}

class TermsAndConditionsFailure extends TermsAndConditionsState {
  final String message;
  TermsAndConditionsFailure(this.message);
}
