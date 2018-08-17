import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/network/response/detail/movie_details_response.dart';
import 'package:flutter_movie_browser/network/request/requests.dart';
import 'package:flutter_movie_browser/database/favorite_movie_database.dart';
import 'package:flutter_movie_browser/util/util.dart';

class BottomButtonsWidget extends StatefulWidget {
  final int id;
  final MovieDetailsResponse movieDetailsResponse;

  BottomButtonsWidget(this.id, this.movieDetailsResponse);

  @override
  _BottomButtonsWidgetState createState() => _BottomButtonsWidgetState();
}

class _BottomButtonsWidgetState extends State<BottomButtonsWidget> {
  var favoriteMovieDatabase = FavoriteMovieDatabase();

  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        favoriteMovieDatabase.removeFavoriteMovie(widget.id);

        final snackbar = SnackBar(content: Text("Removed"));
        Scaffold.of(context).showSnackBar(snackbar);

        _isFavorited = false;
      } else {
        favoriteMovieDatabase.addFavoriteMovie(widget.id,
            widget.movieDetailsResponse.title,
            widget.movieDetailsResponse.overview,
            widget.movieDetailsResponse.posterPath);

        final snackbar = SnackBar(content: Text("Added"));
        Scaffold.of(context).showSnackBar(snackbar);

        _isFavorited = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    favoriteMovieDatabase.checkMovieExist(widget.id).then(
        (bool exists) {
          setState(() {
            _isFavorited = exists;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.movie, color: Theme.of(context).primaryColor,),
              onPressed: () {
                Requests.openIMDBPage(widget.movieDetailsResponse.imdbId);
              }
            ),
            Container(
              child: Text("IMDB",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Utils().shareMovie(widget.movieDetailsResponse.title, widget.movieDetailsResponse.imdbId);
                }
            ),
            Container(
              child: Text("SHARE",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: (_isFavorited
                  ? Icon(Icons.favorite, color: Theme.of(context).primaryColor)
                  : Icon(Icons.favorite_border, color: Theme.of(context).primaryColor)
              ),
              onPressed: _toggleFavorite,
            ),
            Container(
              child: Text("FAVORITE",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ],
    );
  }
}