import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../generated/locale_keys.g.dart';

class CompletedPaidModel {
  bool? status;
  dynamic message;

  CompletedPaidModel({this.status, this.message});

  CompletedPaidModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }

  String getLocalizedMessage(BuildContext context) {
    if (message == null) return LocaleKeys.status_update_success_payment.tr();
    return context.getLocalizedMessage(message, fallback: LocaleKeys.status_update_success_payment.tr());
  }
}
