import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/network/response/upcoming/movie_overview.dart';
import 'package:flutter_movie_browser/ui/moviedetails/movie_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieOverviewListView extends StatelessWidget {
  List<MovieOverview> movieOverviewList = <MovieOverview>[];

  MovieOverviewListView(this.movieOverviewList);

  @override
  Widget build(BuildContext context) {
    final Iterable<Container> customListRow =
        movieOverviewList.map((MovieOverview movie) {
      return Container(
          margin: EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie.id)));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: "https://image.tmdb.org/t/p/w500/${movie
                        .posterPath}",
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TitleTextWidget(movie.title),
                        Container(
                            margin: EdgeInsets.only(top: 16.0),
                            child: OverviewTextWidget(movie.overview))
                      ],
                    ),
                  ))
                ],
              )));
    });

    final List<Widget> divided = customListRow.toList();

    return ListView(
      children: divided,
    );
  }
}

class TitleTextWidget extends StatelessWidget {
  final String title;

  TitleTextWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }
}

class OverviewTextWidget extends StatelessWidget {
  final String overview;

  OverviewTextWidget(this.overview);

  @override
  Widget build(BuildContext context) {
    return Text(
      overview,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12.0),
    );
  }
}
