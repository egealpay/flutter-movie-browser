/*import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_movie_browser/network/response/detail/MovieDetailsResponse.dart';

class FavoriteMovieDatabase {
  static final FavoriteMovieDatabase _favoriteMovieDatabase = FavoriteMovieDatabase
      ._internal();

  Database db;
  bool didInit = false;

  final String TABLE_NAME = "FAVORITE_MOVIE_TABLE";
  final String ID = "id";
  final String TITLE = "title";
  final String OVERVIEW = "overview";
  final String POSTER_PATH = "poster_path";
  final String GENRES = "genres";
  final String RELEASE_DATE = "release_date";
  final String RUNTIME = "runtime";
  final String BUDGET = "budget";

  static FavoriteMovieDatabase get() => _favoriteMovieDatabase;

  FavoriteMovieDatabase._internal();

  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return db;
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favoritemovie.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $TABLE_NAME ("
                  "$ID STRING PRIMARY KEY,"
                  "$TITLE TEXT,"
                  "$OVERVIEW TEXT,"
                  "$POSTER_PATH TEXT,"
                  "$GENRES TEXT,"
                  "$RELEASE_DATE TEXT,"
                  "$RUNTIME INTEGER,"
                  "$BUDGET INTEGER"
                  ")");
        });
  }

  /// Get all books with ids, will return a list with all the books found
  Future<List<MovieDetailsResponse>> getBooks(List<String> ids) async{
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    var idsString = ids.map((it) => '"$it"').join(',');
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${Book.db_id} IN ($idsString)');
    List<Book> books = [];
    for(Map<String, dynamic> item in result) {
      books.add(new Book.fromMap(item));
    }
    return books;
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

}*/