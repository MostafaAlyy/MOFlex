import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE movies(
        name TEXT PRIMARY KEY NOT NULL,
        dateTime TEXT,
        link TEXT,
        description TEXT,
        img TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """).then((value) => print("TABLE movies created")).catchError((e) {
          print(e);
        });
    await database.execute("""CREATE TABLE series(
        name TEXT PRIMARY KEY NOT NULL,
        dateTime TEXT,
        links TEXT,
        description TEXT,
        img TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """).then((value) => print("TABLE series created")).catchError((e) {
          print(e);
        });
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'favorites.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> addMovieToFavorites({
    required String img,
    required String link,
    required String description,
    required String name,
    required String dateTime,
  }) async {
    final db = await SQLHelper.db();

    final data = {
      'img': img,
      'link': link,
      'description': description,
      'name': name,
      'dateTime': dateTime,
    };
    final id = await db.insert('movies', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> addSeriesToFavorites({
    required String img,
    required String description,
    required String name,
    required String dateTime,
  }) async {
    final db = await SQLHelper.db();

    final data = {
      'img': img,
      'description': description,
      'name': name,
      'dateTime': dateTime,
    };
    final id = await db.insert('series', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getFavoritesMovies() async {
    final db = await SQLHelper.db();
    return db.query('movies', orderBy: "name");
  }

  static Future<List<Map<String, dynamic>>> getFavoritesSeries() async {
    final db = await SQLHelper.db();
    return db.query('series', orderBy: "name");
  }

  static Future<void> deleteMovieFromFavorites(String name) async {
    final db = await SQLHelper.db();
    try {
      await db
          .rawDelete('DELETE FROM movies WHERE name = ?', [name]).then((value) {
        print("$name deleted ");
      });
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteSeriesFromFavorites(String name) async {
    final db = await SQLHelper.db();

    try {
      await db
          .rawDelete('DELETE FROM series WHERE name = ?', [name]).then((value) {
        print("$name deleted ");
      });
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
