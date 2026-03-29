
import 'package:flutter/material.dart' hide NavigationBar;
import 'package:zoom_provider/core/routes/routes.dart';
import '../../feature/app_section/presentation/view/app_section.dart';
import '../../feature/auth/presentation/view/login_screen.dart';
import '../../feature/inbording/IntroView.dart';
import '../../feature/inbording/language_screen.dart';
import '../../feature/inbording/splash.dart';



class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());
      case Routes.languageScreen:
        return MaterialPageRoute(builder: (_) => LanguageScreen());
      case Routes.introView:
        return MaterialPageRoute(builder: (_) => const IntroView());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => MainLayout(

        )
    );
  }
}
