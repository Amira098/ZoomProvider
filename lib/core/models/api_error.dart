import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../generated/locale_keys.g.dart';

class ApiError {
  final Map<String, dynamic>? message;
  final Map<String, dynamic>? errors;

  ApiError({this.message, this.errors});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] as Map<String, dynamic>?,
      errors: json['errors'] as Map<String, dynamic>?,
    );
  }

  /// ✅ يرجع الرسالة حسب اللغة الحالية للتطبيق
  String getLocalizedMessage(BuildContext context) {
    if (message == null) return LocaleKeys.general_unexpected_error.tr();

    final currentLocale = EasyLocalization.of(context)?.locale.languageCode;

    if (currentLocale == "ar") {
      return message?['ar'] ?? LocaleKeys.general_unexpected_error.tr();
    } else {
      return message?['en'] ?? LocaleKeys.general_unexpected_error.tr();
    }
  }


  /// ✅ لو فيه Errors مفصلة (زي email/phone) نرجع أول واحدة
  String? get firstFieldError {
    if (errors == null) return null;
    if (errors!['errors'] is Map) {
      final firstKey = (errors!['errors'] as Map).keys.first;
      final firstError = (errors!['errors'][firstKey] as List).first;
      return firstError.toString();
    }
    return null;
  }
}
