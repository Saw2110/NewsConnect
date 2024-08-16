import 'package:sqflite/sqflite.dart';

import '../../../../core/core.dart';
import '../../news.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getArticles();
  Future<int> saveArticles(List<ArticleModel> articleList);
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final Database database;

  ArticleLocalDataSourceImpl({required this.database});

  @override
  Future<List<ArticleModel>> getArticles() async {
    String myQuery = ''' SELECT * FROM ${DatabaseConst.articletable} ''';

    final List<Map<String, dynamic>> mapData = await database.rawQuery(myQuery);

    final result =
        mapData.map((json) => ArticleModel.fromDatabase(json)).toList();

    return result;
  }

  @override
  Future<int> saveArticles(List<ArticleModel> articleList) async {
    int totalInserted = 0;
    database.rawQuery('DELETE FROM ${DatabaseConst.articletable}');
    for (var element in articleList) {
      int rowsAffected = await database.insert(
        DatabaseConst.articletable,
        element.toJson(),
      );
      totalInserted += rowsAffected;
    }
    return totalInserted;
  }
}
