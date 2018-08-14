import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/network/Requests.dart';
import 'package:flutter_movie_browser/network/response/detail/MovieDetailsResponse.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movie_browser/util/strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  MovieDetailsScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetailsResponse>(
          future: Requests.getMovieDetails(id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error Occured");
            }

            return snapshot.hasData
                ? ActivityScreen(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  final MovieDetailsResponse movieDetails;

  ActivityScreen(this.movieDetails);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: DetailsWidget(movieDetails),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text(movieDetails.title)]),
                background: CachedNetworkImage(
                  imageUrl: "https://image.tmdb.org/t/p/w500/${movieDetails
                      .posterPath}",
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        });
  }
}

class DetailsWidget extends StatelessWidget {
  final MovieDetailsResponse movieDetails;

  DetailsWidget(this.movieDetails);

  String getGenres() {
    String genres = "| ";

    movieDetails.genreList
        .forEach((genre) => genres += genre.toString() + " | ");

    return genres;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Text(getGenres()), margin: EdgeInsets.only(bottom: 8.0)),
            Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500/${movieDetails
                            .posterPath}",
                        height: 120.0,
                        fit: BoxFit.fill),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //NOT WORKING!
                              children: <Widget>[
                                generateRow(
                                    Strings.released, movieDetails.releaseDate),
                                generateRow(Strings.runtime,
                                    movieDetails.runtime.toString()),
                                generateRow(Strings.budget,
                                    movieDetails.budget.toString())
                              ],
                            )))
                  ],
                )),
            Text(movieDetails.overview),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: generateBottomButtons(Icons.movie, "IMDB"),
                      onTap: () async {
                        const url = 'https://www.imdb.com/title/';
                        if (await canLaunch(url)) {
                          await launch("$url${movieDetails.imdbId}");
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    GestureDetector(
                      child: generateBottomButtons(Icons.share, "SHARE"),
                      onTap: () {
                        Share.share("Check this movie: ${movieDetails
                            .title}\n https://www.imdb.com/title/${movieDetails
                            .imdbId}");
                      },
                    ),
                    generateBottomButtons(Icons.favorite, "FAVORITE")
                  ],
                ))
          ],
        ));
  }

  Row generateRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text(key), Text(value)],
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
