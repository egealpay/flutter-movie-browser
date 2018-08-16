import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/FavoriteMovieDatabase.dart';
import 'package:flutter_movie_browser/main.dart';

class FavoritesScreen extends StatelessWidget {
  var favoriteMovieDatabase = FavoriteMovieDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Favorites")
      ),
      body: FutureBuilder(
          future: favoriteMovieDatabase.getAllFavoriteMovies(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error Occured"));
            }
            return snapshot.hasData
                ? UpcomingsListView(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}
