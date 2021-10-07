import 'package:save_data_locally_with_sqlite/database/local_database.dart';
import 'package:sqflite/sqflite.dart';

Future<void> InsertData(String note, String datetime) async {
  Database? db = await LocalDatabase.instance.database;

  await db!.rawQuery('''
  INSERT INTO data (datetime,note,timestamp) VALUES ('$datetime','$note',CURRENT_TIMESTAMP)
  ''');
}

Future<List<Map>> GetData() async {
  Database? db = await LocalDatabase.instance.database;
  List<Map> list = await db!.rawQuery('''
  SELECT * FROM data ORDER BY timestamp DESC
  ''');
  return list;
}

Future<void> DeleteData(String datetime) async {
  Database? db = await LocalDatabase.instance.database;
  await db!.rawQuery('''
  DELETE FROM data WHERE datetime='$datetime' 
  ''');
}
