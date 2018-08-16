import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/network/response/upcoming/movie_overview.dart';
import 'package:flutter_movie_browser/network/response/upcoming/movie_overview_response.dart';
import 'package:flutter_movie_browser/ui/moviedetails/movie_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movie_browser/network/request/requests.dart';

class MovieOverviewListView extends StatefulWidget {
  List<MovieOverview> movieOverviewList = <MovieOverview>[];
  final String currentTab;

  bool isPerformingRequest = false;

  MovieOverviewListView(this.movieOverviewList, this.currentTab);

  @override
  _MovieOverviewListViewState createState() => _MovieOverviewListViewState();
}

class _MovieOverviewListViewState extends State<MovieOverviewListView> {

  ScrollController _scrollController = new ScrollController();

  int page = 2;

  void loadResult(MovieOverviewResponse movieOverviewResponse) {
    widget.movieOverviewList.addAll(movieOverviewResponse.movieOverviewList);
    page++;
    widget.isPerformingRequest = false;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !widget.isPerformingRequest) {
        widget.isPerformingRequest = true;
        setState(() {
          switch(widget.currentTab){
            case "UPCOMING":
              Requests.getUpcomingMovies(page).then(
                      (MovieOverviewResponse movieOverviewResponse) {
                    loadResult(movieOverviewResponse);
                  }
              );
              break;
            case "NOWPLAYING":
              Requests.getNowPlayingMovies(page).then(
                      (MovieOverviewResponse movieOverviewResponse) {
                    loadResult(movieOverviewResponse);
                  }
              );
              break;
            case "POPULAR":
              Requests.getPopularMovies(page).then(
                      (MovieOverviewResponse movieOverviewResponse) {
                    loadResult(movieOverviewResponse);
                  }
              );
              break;
            case "TOPRATING":
              Requests.getTopRatingMovies(page).then(
                      (MovieOverviewResponse movieOverviewResponse) {
                    loadResult(movieOverviewResponse);
                  }
              );
              break;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<Container> customListRow =
        widget.movieOverviewList.map((MovieOverview movie) {  // Access variable in StatefulWidget
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
      controller: _scrollController
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
