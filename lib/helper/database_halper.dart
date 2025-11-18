import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/store_model.dart';

class DbService {
  static final DbService _instance = DbService._internal();
  factory DbService() => _instance;
  DbService._internal();

  Database? _db;
  Future<Database> get db async {
    if (_db != null) return _db!;
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pas_mobile.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        image TEXT,
        rate REAL,
        count INTEGER
      )
    ''');
  }

  Future<void> insertBookmark(Storemodel item) async {
    final database = await db;
    await database.insert(
      'bookmarks',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookmark(int id) async {
    final database = await db;
    await database.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> existsBookmark(int id) async {
    final database = await db;
    final res = await database.query('bookmarks', where: 'id = ?', whereArgs: [id], limit: 1);
    return res.isNotEmpty;
  }

  Future<List<Storemodel>> getBookmarks() async {
    final database = await db;
    final res = await database.query('bookmarks', orderBy: 'title');
    return res.map((m) => Storemodel.fromMap(m)).toList();
  }
}