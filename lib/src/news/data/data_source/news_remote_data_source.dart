import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../news.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final APIProvider apiProvider;

  ArticleRemoteDataSourceImpl({required this.apiProvider});

  @override
  Future<List<ArticleModel>> getArticles() async {
    final yesterdayDateTime = DateTime.now().subtract(const Duration(days: 1));
    final from = "$yesterdayDateTime".substring(0, 10);
    String endPoint =
        "/everything?q=tesla&from=$from&sortBy=publishedAt&apiKey=${ApiConst.apiKey}";

    try {
      var response = await apiProvider.getAPI(endPoint: endPoint);
      final List<dynamic> articlesJson = response['articles'];

      return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("$e");
      throw Exception('Failed to load articles');
    }
  }
}
