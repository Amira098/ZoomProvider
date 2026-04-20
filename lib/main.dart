import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'core/constants/app_values.dart';
import 'core/di/service_locator.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/serves/one_signal_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_shared_preference.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
late OneSignalService oneSignalService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesUtils.init();
  await configureDependencies();

  oneSignalService = OneSignalService.getInstance(rootNavigatorKey);

  await oneSignalService.init(
    appId: AppValues.oneSignalAppId,
    debug: true,
  );

  runApp(
    EasyLocalization(
      supportedLocales: AppValues.supportedLocales,
      fallbackLocale: AppValues.englishLocale,
      path: AppValues.pathTranslation,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _determineStartScreen() async {
    final token = SharedPreferencesUtils.getData(key: AppValues.token);
    return token != null ? Routes.appSection : Routes.splash;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return FutureBuilder<String>(
          future: _determineStartScreen(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            return SkeletonizerConfig(
              data: SkeletonizerConfigData(
                effect: ShimmerEffect(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                ),
              ),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: rootNavigatorKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppTheme.lightTheme,
                title: AppValues.appTitle,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: snapshot.data!,
              ),
            );
          },
        );
      },
    );
  }
}