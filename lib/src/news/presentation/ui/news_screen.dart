import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/core/core.dart';

import '../../news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewsViewScreen();
  }
}

class NewsViewScreen extends StatefulWidget {
  const NewsViewScreen({super.key});

  @override
  State<NewsViewScreen> createState() => _NewsViewScreenState();
}

class _NewsViewScreenState extends State<NewsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<NewsBloc>().add(GetAllNews());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discover",
              style: AppTextStyle.h1Bold.copyWith(fontSize: 26.0),
            ),
            Text("News from all around the world", style: AppTextStyle.h2),
            10.yGap,
            AppTextFormField(
              controller: context.read<NewsBloc>().searchController,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune),
              onChanged: (text) {
                if (text!.isNotEmpty) {
                  context.read<NewsBloc>().add(NewsSearchEvent(text: text));
                } else {
                  context.read<NewsBloc>().add(GetAllNews());
                }
              },
            ),
            20.yGap,
            Expanded(child: _buildNewsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const CustomLoading();
        }
        if (state.status == Status.error) {
          context.showSnackBar(
            message: state.errorMessage ?? 'Unknown error',
          );
        }
        final horizontalArticles = state.newsModel.take(5).toList();
        final verticalArticles = state.newsModel.skip(5).toList();
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHorizontalNewsList(horizontalArticles),
              10.yGap,
              _buildVerticalNewsList(verticalArticles),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHorizontalNewsList(List<Article> newsModel) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100.0, maxHeight: 320.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: newsModel.length,
        itemBuilder: (context, index) {
          final article = newsModel[index];
          return NewsItem(
            article: article,
            isHorizontal: true,
            onTap: () {
              NavigationService.pushNamed(
                AppRoutes.newsDetailsScreen,
                arguments: article,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildVerticalNewsList(List<Article> newsModel) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsModel.length,
      itemBuilder: (context, index) {
        final article = newsModel[index];
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
  }
}
