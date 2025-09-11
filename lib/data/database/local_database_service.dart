import 'package:restaurant_app/data/models/request/request.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const _databaseName = 'foodiehub-app.db';
  static const _tableName = 'restaurant';
  static const _version = 1;

  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )
      """);
  }

  Future<Database> _initializeDatabase() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  Future<int> insertItem(RestaurantList restaurant) async {
    final db = await _initializeDatabase();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<RestaurantList>> getAllItem() async {
    final db = await _initializeDatabase();

    final result = await db.query(_tableName);
    return result.map((data) => RestaurantList.fromJson(data)).toList();
  }

  Future<RestaurantList?> getItemById(int id) async {
    final db = await _initializeDatabase();

    final results = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    return results.isEmpty ? null : RestaurantList.fromJson(results.first);
  }

  Future<int> removeItem(int id) async {
    final db = await _initializeDatabase();

    final result = await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }
}
