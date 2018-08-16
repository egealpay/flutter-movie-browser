import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/network/response/detail/movie_details_response.dart';
import 'package:share/share.dart';
import 'package:flutter_movie_browser/network/request/requests.dart';
import 'package:flutter_movie_browser/database/favorite_movie_database.dart';

class BottomButtonsWidget extends StatelessWidget {
  final int id;
  final MovieDetailsResponse movieDetailsResponse;

  BottomButtonsWidget(this.id, this.movieDetailsResponse);

  var favoriteMovieDatabase = FavoriteMovieDatabase();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          child: generateBottomButtons(Icons.movie, "IMDB"),
          onTap: () {
            Requests.openIMDBPage(movieDetailsResponse.imdbId);
          },
        ),
        GestureDetector(
          child: generateBottomButtons(Icons.share, "SHARE"),
          onTap: () {
            Share.share("Check this movie: ${movieDetailsResponse
                .title}\n https://www.imdb.com/title/${movieDetailsResponse
                .imdbId}");
          },
        ),
        GestureDetector(
            onTap: () {
              favoriteMovieDatabase.addFavoriteMovie(
                id,
                movieDetailsResponse.title,
                movieDetailsResponse.overview,
                movieDetailsResponse.posterPath,
              );
              final snackbar = SnackBar(content: Text("Added"));
              Scaffold.of(context).showSnackBar(snackbar);
            },
            child: generateBottomButtons(Icons.favorite, "FAVORITE")
        )
      ],
    );
  }

  Column generateBottomButtons(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(label,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)),
        )
      ],
    );
  }
}