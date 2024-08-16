import 'package:sqflite/sqflite.dart';

import 'database_const.dart';

class CreateTable {
  Database db;
  CreateTable(this.db);

  /// [articles TABLE]
  articlesTable() async {
    await db
        .execute(''' CREATE TABLE if not exists ${DatabaseConst.articletable} (
                                                ${DatabaseConst.sourceId} TEXT,
                                                ${DatabaseConst.sourceName} TEXT,
                                                ${DatabaseConst.author} TEXT,
                                                ${DatabaseConst.title} TEXT,
                                                ${DatabaseConst.description} TEXT,
                                                ${DatabaseConst.url} TEXT,
                                                ${DatabaseConst.urlToImage} TEXT,
                                                ${DatabaseConst.publishedAt} TEXT,
                                                ${DatabaseConst.content} TEXT
                                            ) ''');
  }

  /// [fav TABLE]
  favTable() async {
    await db.execute(''' CREATE TABLE if not exists ${DatabaseConst.favtable} (
                                                ${DatabaseConst.sourceId} TEXT,
                                                ${DatabaseConst.sourceName} TEXT,
                                                ${DatabaseConst.author} TEXT,
                                                ${DatabaseConst.title} TEXT,
                                                ${DatabaseConst.description} TEXT,
                                                ${DatabaseConst.url} TEXT,
                                                ${DatabaseConst.urlToImage} TEXT,
                                                ${DatabaseConst.publishedAt} TEXT,
                                                ${DatabaseConst.content} TEXT
                                            ) ''');
  }
}
