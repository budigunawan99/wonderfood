import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:wonderfood/data/model/restaurant.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurant-catalogue-app.db';
  static const String _tableName = 'restaurant';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      pictureId TEXT,
      city TEXT,
      rating REAL,
      address TEXT,
      categories TEXT,
      menus TEXT,
      customerReviews TEXT
     )
     """);
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(Restaurant restaurant) async {
    try {
      final db = await _initializeDb();

      final data = restaurant.toJson();
      final id = await db.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<List<Restaurant>> getAllItems() async {
    try {
      final db = await _initializeDb();
      final results = await db.query(_tableName);

      return results.map((result) => Restaurant.fromJson(result)).toList();
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<Restaurant?> getItemById(String id) async {
    try {
      final db = await _initializeDb();
      final results = await db.query(
        _tableName,
        where: "id = ?",
        whereArgs: [id],
        limit: 1,
      );
      if (results.isNotEmpty) {
        return results.map((result) => Restaurant.fromJson(result)).first;
      } else {
        return null;
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<int> removeItem(String id) async {
    try {
      final db = await _initializeDb();

      final result = await db.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [id],
      );
      return result;
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }
}
