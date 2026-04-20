import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  OneSignalService(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  static OneSignalService? _instance;

  static OneSignalService getInstance(GlobalKey<NavigatorState> key) {
    _instance ??= OneSignalService(key);
    return _instance!;
  }

  Future<void> init({
    required String appId,
    bool debug = false,
  }) async {
    if (debug) OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(appId);

    await OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      _handleOpen(data);
    });
  }

  void _handleOpen(Map<String, dynamic>? data) {
    final nav = navigatorKey.currentState;
    if (nav == null) return;

    final screen = (data?['screen'] as String?)?.trim();

    switch (screen) {
      case 'order_details':
      // nav.pushNamed(Routes.orderDetails);
        break;
      default:
      // nav.pushNamed(Routes.appSection);
        break;
    }
  }

  /// 🔥 أهم دالة (ربط اليوزر)
  Future<void> loginUser(String userId) async {
    await OneSignal.login(userId);

    await OneSignal.User.addTags({
      "user_id": userId,
    });
  }

  Future<void> logout() async {
    await OneSignal.logout();
  }
}