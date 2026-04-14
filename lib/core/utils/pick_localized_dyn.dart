import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String? pickLocalizedDyn(dynamic messageLike, bool isAr) {
  if (messageLike == null) return null;
  if (messageLike is String) return messageLike;

  try {
    final ar = (messageLike as dynamic).ar as String?;
    final en = (messageLike as dynamic).en as String?;
    final primary = isAr ? ar : en;
    final fallback = isAr ? en : ar;
    return (primary != null && primary.trim().isNotEmpty)
        ? primary
        : (fallback ?? '');
  } catch (_) {
    try {
      final ar = (messageLike as Map)['ar'] as String?;
      final en = (messageLike as Map)['en'] as String?;
      final primary = isAr ? ar : en;
      final fallback = isAr ? en : ar;
      return (primary != null && primary.trim().isNotEmpty)
          ? primary
          : (fallback ?? '');
    } catch (_) {
      return messageLike.toString();
    }
  }
}

extension LocalizationExtension on BuildContext {
  String getLocalizedMessage(dynamic message, {String fallback = ""}) {
    final isAr = locale.languageCode == 'ar';
    return pickLocalizedDyn(message, isAr) ?? fallback;
  }
}