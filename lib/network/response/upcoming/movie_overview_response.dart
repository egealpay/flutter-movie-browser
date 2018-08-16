import 'package:flutter_movie_browser/network/response/upcoming/movie_overview.dart';

class MovieOverviewResponse {
  final List<MovieOverview> movieOverviewList;

  MovieOverviewResponse(this.movieOverviewList);

  MovieOverviewResponse.fromJson(Map<String, dynamic> json)
      : movieOverviewList = (json["results"] as List)
            .map((eachItem) => MovieOverview.fromJson(eachItem))
            .toList();
}
