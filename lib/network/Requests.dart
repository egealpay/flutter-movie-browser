import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_movie_browser/network/response/upcoming/UpcomingMoviesResponse.dart';
import 'package:flutter_movie_browser/network/response/detail/MovieDetailsResponse.dart';

class Requests {
  static const String BASE_URL = "api.themoviedb.org";

  static const String TMDB_API_KEY = "65dd7f149cc5dc1f35fbedbc35c534ed";
  static final String API_KEY_KEY = "api_key";

  static Future<UpcomingMoviesResponse> getUpcomingMovies() async {
    String url = Uri.https(
        BASE_URL, "/3/movie/upcoming", {API_KEY_KEY: TMDB_API_KEY}).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return UpcomingMoviesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<MovieDetailsResponse> getMovieDetails(String movieID) async {
    String url = Uri.https(
        BASE_URL, "/3/movie/$movieID", {API_KEY_KEY: TMDB_API_KEY}).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieDetailsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
