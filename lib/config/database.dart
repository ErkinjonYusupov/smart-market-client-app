import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  Database? db;
  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    db = await openDatabase(path,
        version: 2,
        onConfigure:(db)=> _onConfigure(db),
        onCreate: (db, version) => _createDb(db));
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static void _createDb(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS user(
            id INTEGER NOT NULL,
            title varchar(100) not null,
            phone varchar(20) not null,
          )''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS transactions(
            id INTEGER NOT NULL,
            userFullName varchar(100) not null,
            type varchar(10) not null,
            amount integer not null,
            repaymentDate varchar(15),
            createdAt varchar(100) 
          )''');
  }
}
