import 'package:sqflite/sqflite.dart';

import '../../news.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getArticles();
  Future<List<ArticleModel>> saveArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final Database database;

  ArticleLocalDataSourceImpl({required this.database});

  @override
  Future<List<ArticleModel>> getArticles() async {
    return [];
  }

  @override
  Future<List<ArticleModel>> saveArticles() async {
    int totalInserted = 0;
    // database.rawQuery('DELETE FROM ${DatabaseDetails.catTable}');
    // database.rawQuery('DELETE FROM ${DatabaseDetails.productTable}');

    // for (var element in meal) {
    //   String sql = '''
    //       INSERT INTO ${DatabaseDetails.catTable} (${DatabaseDetails.catId}, ${DatabaseDetails.catName},${DatabaseDetails.catStatus})
    //       VALUES (?,?,?);
    //   ''';
    //   int rowsAffected = await database
    //       .rawInsert(sql, [element.id, element.name, element.status]);

    //   totalInserted += rowsAffected;
    //   await _addProduct(element.products);
    // }
    // return totalInserted;
    return [];
  }
}
