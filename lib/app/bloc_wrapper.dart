import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/dependency_injection/locator.dart';
import 'package:news_connect/src/favourites/favourites.dart';
import 'package:news_connect/src/splash/bloc/splash_bloc.dart';

import '../src/auth/auth.dart';
import '../src/news/presentation/bloc/news_bloc.dart';
import '../src/profile/presentation/cubit/user_cubit.dart';

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
        BlocProvider(create: (_) => NewsBloc(sl())),
        BlocProvider(
          create: (_) => UserCubit(
            updateUserUseCase: sl(),
            getUserUseCase: sl(),
            firebaseAuth: sl(),
          ),
        ),

        ///
        BlocProvider(
          create: (_) => FavoriteCubit(
            removeFavoriteUseCase: sl(),
            addFavoriteUseCase: sl(),
            getFavoritesUseCase: sl(),
            isFavoriteUseCase: sl(),
          ),
        ),

        ///
      ],
      child: child,
    );
  }
}
