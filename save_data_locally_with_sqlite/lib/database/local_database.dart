import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final _databaseName = "database.db";
  static final _databaseVersion = 1;

  static Database? _database;

  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  Future<Database?> get database async {
    if (_database != null)
      return _database; //if database already present it return the database else create a new one then return it
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$_databaseName');
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, int) async {
      await db.execute('''
              CREATE TABLE data (
              datetime TEXT,
              note TEXT,
              timestamp TIMESTAMP
            )
           ''');
    });
  }
}
