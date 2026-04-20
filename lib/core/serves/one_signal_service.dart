import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

@lazySingleton
class OneSignalService {
  OneSignalService(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;
  bool _isInitialized = false;

  Future<void> init({
    required String appId,
    bool debug = false,
  }) async {
    if (_isInitialized) return;

    if (debug) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

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

    _isInitialized = true;
  }

  void _handleOpen(Map<String, dynamic>? data) {
    final nav = navigatorKey.currentState;
    if (nav == null) return;

    final screen = (data?['screen'] as String?)?.trim();

    switch (screen) {
      case 'order_details':
      // nav.pushNamed(...);
        break;
      default:
        break;
    }
  }

  Future<void> loginUser(String userId) async {
    final trimmedUserId = userId.trim();
    if (trimmedUserId.isEmpty) return;

    await OneSignal.login(trimmedUserId);
    await OneSignal.User.addTags({
      'user_id': trimmedUserId,
    });
  }

  Future<void> logout() async {
    await OneSignal.logout();
  }
}