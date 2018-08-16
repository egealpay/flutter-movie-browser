import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/database/favorite_movie_database.dart';
import 'package:flutter_movie_browser/ui/tab/base_tab.dart';

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
                ? MovieOverviewListView(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}
