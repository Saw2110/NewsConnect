import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
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
    return isHorizontal
        ? Container(
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: AppColors.white,
            ),
            width: context.screenWidth * .8,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        height: 180.0,
                        width: context.screenWidth * .8,
                        fit: BoxFit.cover,
                        imageUrl: article.urlToImage,
                        placeholder: (context, url) => const CustomLoading(),
                        errorWidget: (context, url, error) =>
                            Container(color: AppColors.lightGrey),
                      ),
                    ),

                    ///
                    5.yGap,
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          _buildHeader(isHorizontal: isHorizontal),
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

                    ///
                  ],
                ),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: AppColors.white,
            ),
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
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
                    _buildArticleImage(),
                  ],
                ),
              ),
            ),
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

  Widget _buildArticleImage() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CachedNetworkImage(
          height: 100.0,
          fit: BoxFit.cover,
          imageUrl: article.urlToImage,
          placeholder: (context, url) => const CustomLoading(),
          errorWidget: (context, url, error) =>
              Container(color: AppColors.lightGrey),
        ),
      ),
    );
  }
}
