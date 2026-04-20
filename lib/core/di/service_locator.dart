import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final serviceLocator = GetIt.instance;

@module
abstract class AppModule {
  @lazySingleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}

@InjectableInit()
Future<void> configureDependencies() async {
  await serviceLocator.init();
}