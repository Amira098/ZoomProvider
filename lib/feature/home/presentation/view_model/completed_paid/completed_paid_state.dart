import '../../../data/model/completed_paid_model.dart';

abstract class CompletedPaidState {
  const CompletedPaidState();
}

class CompletedPaidInitial extends CompletedPaidState {
  const CompletedPaidInitial();
}

class CompletedPaidLoading extends CompletedPaidState {
  const CompletedPaidLoading();
}

class CompletedPaidSuccess extends CompletedPaidState {
  final CompletedPaidModel data;

  const CompletedPaidSuccess(this.data);
}

class CompletedPaidFailure extends CompletedPaidState {
  final String message;

  const CompletedPaidFailure(this.message);
}