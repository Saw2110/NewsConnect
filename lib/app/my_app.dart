import 'package:flutter/material.dart';
import 'package:news_connect/app/app.dart';
import 'package:news_connect/core/routes/routes_name.dart';

import '../core/routes/routes_helper.dart';
import '../core/themes/theme_data.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProviderWrapper(
      child: MaterialApp(
        navigatorKey: AppConst.navigationKey,
        title: AppConst.appName,
        scrollBehavior: const ScrollBehavior().copyWith(
          physics: const ClampingScrollPhysics(),
        ),
        theme: AppTheme.themeData,
        initialRoute: AppRoutes.splashPage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
