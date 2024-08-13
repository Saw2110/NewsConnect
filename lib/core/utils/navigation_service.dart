import 'package:flutter/material.dart';
import 'package:news_connect/app/app.dart';

class NavigationService {
  static final NavigatorState _appRouter = AppConst.navigationKey.currentState!;

  static Future<void> pushNamed(String route, {Object? arguments}) {
    return _appRouter.pushNamed(route, arguments: arguments);
  }

  static Future<void> pushReplacementNamed(String route, {Object? arguments}) {
    return _appRouter.pushReplacementNamed(route, arguments: arguments);
  }

  static void pop<T extends Object?>([T? result]) {
    return _appRouter.pop(result);
  }

  static Future<bool> maybePop() {
    return _appRouter.maybePop();
  }

  static void popUntil(RoutePredicate predicate) {
    return _appRouter.popUntil(predicate);
  }
}
