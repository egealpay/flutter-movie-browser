import 'package:flutter_movie_browser/network/response/detail/genre.dart';

class MovieDetailsResponse {
  final String title;
  final String overview;
  final String releaseDate;
  final int runtime;
  final List<Genre> genreList;
  final String posterPath;
  final num voteAverage;
  final int budget;
  final String imdbId;

  MovieDetailsResponse(
      {this.title,
      this.overview,
      this.releaseDate,
      this.runtime,
      this.genreList,
      this.posterPath,
      this.voteAverage,
      this.budget,
      this.imdbId});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
        title: json["title"],
        overview: json["overview"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        genreList: (json["genres"] as List)
            .map((item) => Genre.fromJson(item))
            .toList(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"],
        imdbId: json["imdb_id"],
        budget: json["budget"]);
  }
}
