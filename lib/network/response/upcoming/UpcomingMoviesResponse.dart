import 'package:flutter_movie_browser/network/response/upcoming/UpcomingMovies.dart';

class UpcomingMoviesResponse {
  final List<UpcomingMovies> upcomingMoviesList;

  UpcomingMoviesResponse(this.upcomingMoviesList);

  UpcomingMoviesResponse.fromJson(Map<String, dynamic> json)
      : upcomingMoviesList = (json["results"] as List)
            .map((eachItem) => UpcomingMovies.fromJson(eachItem))
            .toList();
}
