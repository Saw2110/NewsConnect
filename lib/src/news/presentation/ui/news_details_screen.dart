import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../news.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  const NewsDetailsScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      removeAllPadding: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CachedNetworkImage(
            height: context.screenHeight / 3,
            width: context.screenWidth,
            fit: BoxFit.cover,
            imageUrl: article.urlToImage,
            placeholder: (context, url) => const CustomLoading(),
            errorWidget: (context, url, error) =>
                Container(color: AppColors.lightGrey),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(.6),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      NavigationService.pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              (context.screenHeight / 3.5).yGap,
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        _buildAuthorInfo(),
                        _buildArticalDetails(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticalDetails() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            article.title,
            style: AppTextStyle.h1Bold.copyWith(
              color: AppColors.black,
            ),
            textAlign: TextAlign.justify,
          ),
          20.yGap,
          Text(
            article.description,
            style: AppTextStyle.h2,
            textAlign: TextAlign.justify,
          ),
          5.yGap,
          Text(
            article.description,
            style: AppTextStyle.normalText,
            textAlign: TextAlign.justify,
          ),
          TextButton(onPressed: () {}, child: const Text("View More")),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: CachedNetworkImage(
            height: 45.0,
            width: 45.0,
            fit: BoxFit.cover,
            imageUrl: article.urlToImage,
            placeholder: (context, url) => const CustomLoading(),
            errorWidget: (context, url, error) =>
                Container(color: AppColors.lightGrey),
          ),
        ),
        10.xGap,
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                article.author,
                style: AppTextStyle.h1Bold.copyWith(fontSize: 18.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateTime.parse(article.publishedAt).toRetativeFomatWithTime(),
                style: AppTextStyle.h2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
