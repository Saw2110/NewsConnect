import 'package:sqflite/sqflite.dart';

import '../../../../core/core.dart';
import '../../../news/news.dart';

abstract class FavoriteLocalDataSource {
  Future<void> addFavorite(Article article);
  Future<void> removeFavorite(Article article);
  Future<List<Article>> getFavorites();
  Future<bool> isFavorite(Article article);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final Database database;

  FavoriteLocalDataSourceImpl({required this.database});

  @override
  Future<void> addFavorite(Article article) async {
    final articleModel = ArticleModel.fromDomain(article);

    await database.insert(
      DatabaseConst.favtable,
      articleModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(Article article) async {
    await database.delete(
      DatabaseConst.favtable,
      where: 'title = ?',
      whereArgs: [article.title],
    );
  }

  @override
  Future<List<Article>> getFavorites() async {
    final List<Map<String, dynamic>> mapData =
        await database.query(DatabaseConst.favtable);
    return mapData.map((json) => ArticleModel.fromDatabase(json)).toList();
  }

  @override
  Future<bool> isFavorite(Article article) async {
    final List<Map<String, dynamic>> maps = await database.query(
      DatabaseConst.favtable,
      where: 'title = ?',
      whereArgs: [article.title],
    );
    return maps.isNotEmpty;
  }
}
