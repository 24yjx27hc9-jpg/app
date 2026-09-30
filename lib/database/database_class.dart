import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClass {
  static Database? _database;

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async{
    final path = join(
      await getDatabasesPath(),
      'database.db'
    );
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute(
          '''CREATE TABLE Notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NUT NULL,
          text TEXT)'''
        );
      }
    );
  }
}