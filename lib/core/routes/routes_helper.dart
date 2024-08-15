import 'package:flutter/material.dart';
import 'package:news_connect/core/routes/routes_name.dart';
import 'package:news_connect/src/news/domain/entities/news_model.dart';
import 'package:news_connect/src/news/presentation/ui/news_details_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../src/auth/presentation/ui/login/login_screen.dart';
import '../../src/auth/presentation/ui/register/register_screen.dart';
import '../../src/index/index_screen.dart';
import '../../src/splash/splash.dart';

class RouteGenerator {
  static const PageTransitionType _defaultTransition =
      PageTransitionType.rightToLeft;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget page;

    switch (settings.name) {
      case AppRoutes.splashPage:
        page = const SplashScreen();
        break;
      case AppRoutes.loginScreen:
        page = const LoginScreen();
        break;
      case AppRoutes.registerScreen:
        page = const RegisterScreen();
        break;
      case AppRoutes.indexScreen:
        page = const IndexScreen();
        break;
      case AppRoutes.newsDetailsScreen:
        var value = settings.arguments as Article;
        page = NewsDetailsScreen(article: value);
        break;
      default:
        return _errorRoute();
    }

    return PageTransition(
      type: _defaultTransition,
      child: page,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("ROUTE ERROR: Unknown route"),
        ),
      ),
    );
  }
}
