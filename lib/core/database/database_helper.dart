import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database_const.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();

  static final DatabaseProvider instance =
      DatabaseProvider._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initiateDatabase();
    return _database;
  }

  late String path;

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    path = join(directory.path, DatabaseDetails.databaseName);
    return await openDatabase(
      path,
      version: DatabaseDetails.dbVersion,
      onCreate: onCreate,
    );
  }

  Future<void> onDropDatabase() async {
    // Database? db = await instance.database;
    // await db!.delete(DatabaseDetails.catTable);
    // await db.delete(DatabaseDetails.productTable);
  }

  Future<void> onCreate(Database db, int version) async {
    ///
    // await CreateTable(db).categoryTable();
  }
}
