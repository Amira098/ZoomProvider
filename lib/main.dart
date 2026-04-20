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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  await SharedPreferencesUtils.init();
  await configureDependencies();

  await OneSignalService(rootNavigatorKey).init(
    appId: AppValues.oneSignalAppId,
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    _determineStartScreen();
  }

  Future<void> _determineStartScreen() async {
    final token = SharedPreferencesUtils.getData(key: AppValues.token);
    setState(() {
      _initialRoute = token != null ? Routes.appSection : Routes.splash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        if (_initialRoute == null) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return SkeletonizerConfig(
          data: SkeletonizerConfigData(
            effect: ShimmerEffect(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              duration: const Duration(milliseconds: 1000),
            ),
            ignoreContainers: false,
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
            initialRoute: _initialRoute!,
          ),
        );

      },
      child: const SizedBox.shrink(),
    );
  }
}
