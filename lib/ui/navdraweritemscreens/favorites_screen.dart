import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/database/favorite_movie_database.dart';
import 'package:flutter_movie_browser/ui/tab/base_tab.dart';
import 'package:flutter_movie_browser/network/response/upcoming/movie_overview.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with WidgetsBindingObserver{
  var favoriteMovieDatabase = FavoriteMovieDatabase();
  List<MovieOverview> movieOverviewList = List<MovieOverview>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    favoriteMovieDatabase
        .getAllFavoriteMovies()
        .then((List<MovieOverview> list) {
      setState(() {
        movieOverviewList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Favorites")),
        body: MovieOverviewListView(movieOverviewList, "FAVORITE")
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      favoriteMovieDatabase
          .getAllFavoriteMovies()
          .then((List<MovieOverview> list) {
        setState(() {
          movieOverviewList = list;
        });
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
