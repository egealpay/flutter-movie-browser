import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_movie_browser/network/response/upcoming/movie_overview.dart';

class FavoriteMovieDatabase {
  static Database _db;

  final String TABLE_NAME = "FAVORITE_MOVIE_TABLE";
  final String ID = "id";
  final String TITLE = "title";
  final String OVERVIEW = "overview";
  final String POSTER_PATH = "poster_path";

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favorite_movie.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE_NAME ("
        "$ID INTEGER PRIMARY KEY,"
        "$TITLE TEXT,"
        "$OVERVIEW TEXT,"
        "$POSTER_PATH TEXT"
        ")");
  }

  Future<List<MovieOverview>> getAllFavoriteMovies() async {
    var dbHelper = await db;
    var result = await dbHelper.rawQuery('SELECT * FROM $TABLE_NAME');
    List<MovieOverview> favoriteMovies = [];
    for(int i = 0; i < result.length; i++) {
      favoriteMovies.add(
          MovieOverview(
              id: result[i][ID],
              title: result[i][TITLE],
              overview:  result[i][OVERVIEW],
              posterPath: result[i][POSTER_PATH]
          )
      );
    }
    return favoriteMovies;
  }

  Future<int> addFavoriteMovie(
      int id, String title, String overview, String posterPath) async {
    var dbHelper = await db;
    var result = await dbHelper.rawInsert(
        "INSERT INTO $TABLE_NAME($ID, $TITLE, $OVERVIEW, $POSTER_PATH) VALUES(?, ?, ?, ?)",
        [id, title, overview, posterPath]);
    return result;
  }

  checkMovieExist(int id) async {
    var dbHelper = await db;
    var result = await dbHelper.rawQuery("SELECT * FROM $TABLE_NAME WHERE $ID = ?", [id]);
    return result.length;
  }

  Future close() async {
    var dbHelper = await db;
    return dbHelper.close();
  }
}
