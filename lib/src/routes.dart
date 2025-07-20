import 'package:flutter/material.dart';

import 'presentation/pages/pages.dart';
import 'core/utils/animations/fade_route.dart';

class AppRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String dogDetails = '/dogDetails';
  static const String tasteDetails = '/tasteDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return FadeRoute(page: MainPage());
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.dogDetails:
        return MaterialPageRoute(builder: (_) => const DogDetailsPage());
      case AppRoutes.tasteDetails:
        final title = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => TasteDetailsPage(title: title));
      default:
        return MaterialPageRoute(builder: (_) => MainPage());
    }
  }
}
