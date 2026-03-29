import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constants/app_constants.dart';

class DeviceInfo{
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> deviceInfo = {};
    final DeviceInfoPlugin device = DeviceInfoPlugin();
    final networkInfo = NetworkInfo();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String udid = await FlutterUdid.consistentUdid;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await device.androidInfo;
      deviceInfo[IS_PHYSICAL_DEVICE] = androidInfo.isPhysicalDevice;
      deviceInfo[MODEL] = androidInfo.manufacturer;
      deviceInfo[DEVICE_NAME] = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await device.iosInfo;
      deviceInfo[IS_PHYSICAL_DEVICE] = iosInfo.isPhysicalDevice;
      deviceInfo[MODEL] = iosInfo.model;
      deviceInfo[DEVICE_NAME] = iosInfo.name;
    }

    deviceInfo[OS] = Platform.isAndroid ? 'Android' : 'iOS';
    deviceInfo[IP] = await networkInfo.getWifiIP();
    deviceInfo[VERSION] = packageInfo.version;
    deviceInfo[DEVICE_ID] = udid;
    debugPrint('Running on device id: ${deviceInfo[DEVICE_ID]}');

    return deviceInfo;
  }
}
