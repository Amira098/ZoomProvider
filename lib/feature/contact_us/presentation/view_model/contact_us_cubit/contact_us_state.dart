

abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsSuccess extends ContactUsState {
  final String message;
  ContactUsSuccess(this.message);
}

class ContactUsFailure extends ContactUsState {
  final String error;
  ContactUsFailure(this.error);
}
