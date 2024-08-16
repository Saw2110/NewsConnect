import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/core/core.dart';

import '../../../news/news.dart';
import '../../favourites.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().loadFavorites();
    return PageWrapper(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favourites",
              style: AppTextStyle.h1Bold.copyWith(fontSize: 26.0),
            ),
            20.yGap,
            Expanded(
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  if (state.favoriteArticles.isEmpty) {
                    return const Center(child: Text('No favorites yet!'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.favoriteArticles.length,
                    itemBuilder: (context, index) {
                      final article = state.favoriteArticles[index];
                      return NewsItem(
                        article: article,
                        onTap: () {
                          NavigationService.pushNamed(
                            AppRoutes.newsDetailsScreen,
                            arguments: article,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
