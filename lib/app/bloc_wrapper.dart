import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/dependency_injection/locator.dart';
import 'package:news_connect/src/splash/bloc/splash_bloc.dart';

import '../src/auth/auth.dart';

class MultiBlocProviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => LoginBloc(sl())),
        BlocProvider(create: (_) => RegisterBloc(sl())),
      ],
      child: child,
    );
  }
}
