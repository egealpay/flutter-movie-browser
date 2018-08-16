import 'package:flutter/material.dart';

import 'package:flutter_movie_browser/network/request/requests.dart';
import 'package:flutter_movie_browser/network/response/detail/movie_details_response.dart';
import 'package:flutter_movie_browser/ui/moviedetails/widgets/bottom_buttons.dart';
import 'package:flutter_movie_browser/ui/moviedetails/widgets/genres.dart';
import 'package:flutter_movie_browser/ui/moviedetails/widgets/additional_info.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                ? ActivityScreen(snapshot.data, id)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  final MovieDetailsResponse movieDetails;
  final int id;

  ActivityScreen(this.movieDetails, this.id);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: DetailsWidget(movieDetails, id),
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
  final int id;

  DetailsWidget(this.movieDetails, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GenresWidget(movieDetails.genreList),
            AdditionalInfoWidget(
                movieDetails.posterPath,
                movieDetails.releaseDate,
                movieDetails.runtime.toString(),
                movieDetails.budget.toString()),
            Text(movieDetails.overview),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: BottomButtonsWidget(id, movieDetails))
          ],
        ));
  }
}
