// import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
//
// import '../routes/routes.dart'; // حتى نستخدم أسماء الروت الموحّدة لديك
//
// /// خدمة OneSignal مع تنقّل عبر navigatorKey (بدون الحاجة لتمرير context)
// class OneSignalService {
//   OneSignalService(this.navigatorKey);
//
//   final GlobalKey<NavigatorState> navigatorKey;
//
//   Future<void> init({
//     required String appId,
//     bool debug = false,
//   }) async {
//     if (debug) OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//
//     OneSignal.initialize(appId);
//
//     // iOS فقط: اطلب الإذن (على أندرويد 13+ سيُطلب تلقائياً)
//     await OneSignal.Notifications.requestPermission(true);
//
//     // لو التطبيق في الـ Foreground اعرض الإشعار (أو خصّص سلوكك)
//     OneSignal.Notifications.addForegroundWillDisplayListener((event) {
//       event.preventDefault();
//       event.notification.display();
//     });
//
//     // عند النقر على الإشعار
//     OneSignal.Notifications.addClickListener((event) {
//       final data = _asMapStringDynamic(event.notification.additionalData);
//       _handleOpen(data);
//     });
//   }
//
//   /// توحيد الـ payload إلى Map<String, dynamic> بأمان
//   Map<String, dynamic>? _asMapStringDynamic(Map<String, Object?>? raw) {
//     if (raw == null) return null;
//     // نحاول تحويل جميع القيم إلى شكل مقروء (strings / numbers / maps)
//     return raw.map((k, v) => MapEntry(k, v));
//   }
//
//   void _handleOpen(Map<String, dynamic>? data) {
//     final nav = navigatorKey.currentState;
//     if (nav == null) return;
//
//     final screen = (data?['screen'] as String?)?.trim();
//
//     switch (screen) {
//       case 'service_detail':
//       // مثال: لو ترسل service_id داخل payload
//         final serviceId = data?['service_id']?.toString();
//         // غيّر Routes.serviceDetails لو اسم الروت مختلف لديك
//
//         break;
//
//       case 'won_auction':
//         nav.pushNamed(Routes.wonAuctionScreen);
//         break;
//
//       default:
//       // افتراضي: افتح شاشة الرابحين
//         nav.pushNamed(Routes.wonAuctionScreen);
//         break;
//     }
//   }
//
//   // ربط المستخدم بالجهاز عند تسجيل الدخول
//   Future<void> setExternalUserId(String userId) => OneSignal.login(userId);
//
//   // تسجيل الخروج من الإشعارات
//   Future<void> logout() => OneSignal.logout();
//
//   // تعيين Tags للتجزئة
//   Future<void> setTags(Map<String, String> tags) => OneSignal.User.addTags(tags);
//
//   // حذف Tag
//   Future<void> deleteTag(String key) => OneSignal.User.removeTag(key);
// }
