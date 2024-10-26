import 'package:client_mobile_app/exports.dart';
import 'package:client_mobile_app/home/models/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  Database? db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    db = await openDatabase(path,
        version: 2,
        onConfigure: (db) => _onConfigure(db),
        onCreate: (db, version) => _createDb(db));
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static void _createDb(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS products(
            id INTEGER NOT NULL,
            categoryId integer not null,
            title varchar(200) not null,
            barcode varchar(100) not null,
            category varchar(100) not null,
            price integer not null,
            unit varchar(10) not null
          )''');
  }

  // Mahsulotlarni qo'shish yoki yangilash funksiyasi
  Future<void> insertOrUpdateProducts(List<ProductModel> products) async {
    await open();
    // Barcha mahsulotlarni o'chirish
  await db!.delete('products');
    final batch = db!.batch();
    for (var product in products) {
      // Agar mahsulot mavjud bo'lsa, yangilash; mavjud bo‘lmasa, qo‘shish.
      batch.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(
        noResult: true); // Har bir amaliyotni natijasi kerak emas.
  }

   getProducts(
      {int page = 1, int pageSize = 20, int? categoryId}) async {
    await open();
    int offset = (page - 1) * pageSize;

    // Dinamik where va args yaratish
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (categoryId != null) {
      whereClause += 'categoryId = ?';
      whereArgs.add(categoryId);
    }

     // Umumiy yozuvlar sonini olish
    final countResult = await db!.rawQuery(
      'SELECT COUNT(*) FROM products${whereClause.isNotEmpty ? ' WHERE $whereClause' : ''}',
      whereArgs,
    );

    int? total = Sqflite.firstIntValue(countResult);
      int lastPage = (total! / pageSize).ceil();

    final List<Map<String, dynamic>> maps = await db!.query(
      'products',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      limit: pageSize,
      offset: offset,
    );
    return {
      "data":productsFromJson(maps),
      "meta": Pagination.fromJson({
        "current_page":page,
        "last_page":lastPage
      })

    };
    
  }
}
