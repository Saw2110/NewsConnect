import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_connect/core/core.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.yGap,
            Center(
              child: ClipOval(
                child: CachedNetworkImage(
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                  imageUrl: "article.urlToImage",
                  placeholder: (context, url) => const CustomLoading(),
                  errorWidget: (context, url, error) =>
                      Container(color: AppColors.lightGrey),
                ),
              ),
            ),
              
            Text(
              "Full Name",
              style: AppTextStyle.h1Bold,
            ),
            Text(
              "+977-9000000000",
              style: AppTextStyle.h2,
            ),
          ],
        ),
      ),
    );
  }
}
