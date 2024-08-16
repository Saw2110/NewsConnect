import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/core/core.dart';
import 'package:news_connect/dependency_injection/dependency_injection.dart';

import '../../news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(sl()),
      child: const NewsViewScreen(),
    );
  }
}

class NewsViewScreen extends StatefulWidget {
  const NewsViewScreen({super.key});

  @override
  State<NewsViewScreen> createState() => _NewsViewScreenState();
}

class _NewsViewScreenState extends State<NewsViewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsBloc>().add(GetAllNews());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<NewsBloc, NewsState>(
        listenWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        listener: (context, state) => _handleStateChanges(context, state),
        builder: (context, state) {
          if (state is NewsSuccess) {
            return _buildNewsList(context, state.newsModel);
          }
          return const Center(child: Text("No data found."));
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, NewsState state) {
    if (state is NewsLoading) {
      AppLoadingOverlay.of(context).show();
    } else if (state is NewsSuccess || state is NewsError) {
      AppLoadingOverlay.of(context).hide();
      if (state is NewsError) {
        context.showSnackBar(message: state.message);
      }
    }
  }

  Widget _buildNewsList(BuildContext context, List<Article> newsModel) {
    final horizontalArticles = newsModel.take(5).toList();
    final verticalArticles = newsModel.skip(5).toList();

    ///
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsBloc>().add(GetAllNews());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Discover",
              style: AppTextStyle.h1Bold.copyWith(fontSize: 26.0),
            ),
            Text("News from all around the world", style: AppTextStyle.h2),
            10.yGap,
            AppTextFormField(
              controller: TextEditingController(),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune),
            ),
            26.yGap,
            _buildHorizontalNewsList(horizontalArticles),
            10.yGap,
            _buildVerticalNewsList(verticalArticles),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalNewsList(List<Article> newsModel) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100.0, maxHeight: 320.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: (newsModel.length > 10 ? 5 : newsModel.length),
        itemBuilder: (context, index) {
          final article = newsModel[index];
          if (_isRemoved(article)) return const SizedBox.shrink();
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
        if (_isRemoved(article)) return const SizedBox.shrink();
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

  bool _isRemoved(Article article) {
    return article.title == "[Removed]" ||
        article.description == "[Removed]" ||
        article.content == "[Removed]";
  }
}
