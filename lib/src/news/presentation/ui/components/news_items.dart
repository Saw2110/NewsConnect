import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../favourites/favourites.dart';
import '../../../news.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  final bool isHorizontal;
  final void Function()? onTap;

  const NewsItem({
    super.key,
    required this.article,
    this.isHorizontal = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isHorizontal ? 0 : 4.0,
        horizontal: isHorizontal ? 8.0 : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.white,
      ),
      width: isHorizontal ? context.screenWidth * .8 : null,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: isHorizontal
                  ? _buildHorizontalContent(context)
                  : _buildVerticalContent(context),
            ),
          ),
          _buildFavoriteIcon(context, article),
        ],
      ),
    );
  }

  Widget _buildHorizontalContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildArticleImage(context,
            height: 180.0, width: context.screenWidth * .8),
        5.yGap,
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              _buildHeader(isHorizontal: true),
              10.yGap,
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.h1Bold,
              ),
              15.yGap,
              _buildAuthorInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalContent(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              10.yGap,
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.h1Bold,
              ),
              15.yGap,
              _buildAuthorInfo(),
            ],
          ),
        ),
        10.xGap,
        Expanded(child: _buildArticleImage(context, height: 100.0)),
      ],
    );
  }

  Widget _buildHeader({bool isHorizontal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isHorizontal)
          Expanded(
            child: Text(
              article.sourceName,
              style: AppTextStyle.h2,
              maxLines: 1,
            ),
          ),
        if (article.publishedAt.isNotEmpty)
          Expanded(
            child: Text(
              DateTime.parse(article.publishedAt).toRetativeFomatWithTime(),
              style: AppTextStyle.h2,
              maxLines: 1,
              textAlign: isHorizontal ? TextAlign.end : TextAlign.start,
            ),
          ),
      ],
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                  height: 20.0,
                  width: 20.0,
                  fit: BoxFit.cover,
                  imageUrl: article.urlToImage,
                  placeholder: (context, url) => const CustomLoading(),
                  errorWidget: (context, url, error) =>
                      Container(color: AppColors.lightGrey),
                ),
              ),
              5.xGap,
              Expanded(
                flex: 2,
                child: Text(
                  article.author,
                  style: AppTextStyle.h2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.more_horiz, color: AppColors.midGrey),
      ],
    );
  }

  Widget _buildArticleImage(
    BuildContext context, {
    double? height,
    double? width,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: article.urlToImage,
        placeholder: (context, url) => const CustomLoading(),
        errorWidget: (context, url, error) =>
            Container(color: AppColors.lightGrey),
      ),
    );
  }

  Widget _buildFavoriteIcon(BuildContext context, Article article) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (BuildContext context, state) {
        final isFavorite = state.favoriteArticles.contains(article);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.white.withOpacity(.6),
          ),
          child: IconButton(
            onPressed: () async {
              if (isFavorite) {
                await context.read<FavoriteCubit>().removeFavorite(article);
              } else {
                await context.read<FavoriteCubit>().addFavorite(article);
              }
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        );
      },
    );
  }
}
