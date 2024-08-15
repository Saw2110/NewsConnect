import 'package:sqflite/sqflite.dart';

import 'database_const.dart';

class CreateTable {
  Database db;
  CreateTable(this.db);

  /// [articles TABLE]
  articlesTable() async {
    // await db
    //     .execute(''' CREATE TABLE if not exists ${DatabaseDetails.catTable} (
    //                                             ${DatabaseDetails.catId} TEXT,
    //                                             ${DatabaseDetails.catName} TEXT,
    //                                             ${DatabaseDetails.catStatus} TEXT
    //                                         ) ''');
  }
}
