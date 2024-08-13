import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/core/core.dart';
import 'package:news_connect/src/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context).add(CheckLoginStatusEvent());
    return BlocListener<SplashBloc, SplashState>(
      listener: (BuildContext context, state) {
        if (state is SplashLoginSuccess) {
          NavigationService.pushNamed(AppRoutes.indexScreen);
        }
        if (state is SplashLoginFailed) {
          NavigationService.pushNamed(AppRoutes.loginScreen);
        }
      },
      child: PageWrapper(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppAssets.transparentAppIcon,
                height: context.screenHeight / 4,
              ),
              Text(
                "NEWS CONNECT",
                style: AppTextStyle.h1Bold.copyWith(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
