

abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsSuccess extends ContactUsState {
  final dynamic message;
  ContactUsSuccess(this.message);
}

class ContactUsFailure extends ContactUsState {
  final String error;
  ContactUsFailure(this.error);
}

class ContactDetailsLoading extends ContactUsState {}

class ContactDetailsSuccess extends ContactUsState {
  final String number;
  final String email;
  ContactDetailsSuccess({required this.number, required this.email});
}

class ContactDetailsFailure extends ContactUsState {
  final String error;
  ContactDetailsFailure(this.error);
}
