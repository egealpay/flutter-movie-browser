import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_movie_browser/network/response/upcoming/movie_overview_response.dart';
import 'package:flutter_movie_browser/network/response/detail/movie_details_response.dart';

class Requests {
  static const String BASE_URL = "api.themoviedb.org";

  static const String TMDB_API_KEY = "65dd7f149cc5dc1f35fbedbc35c534ed";
  static final String API_KEY_KEY = "api_key";

  static Future<MovieOverviewResponse> getUpcomingMovies() async {
    String url = Uri.https(
        BASE_URL, "/3/movie/upcoming", {API_KEY_KEY: TMDB_API_KEY}).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieOverviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<MovieOverviewResponse> getNowPlayingMovies() async {
    String url = Uri.https(
        BASE_URL, "/3/movie/now_playing", {API_KEY_KEY: TMDB_API_KEY}).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieOverviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<MovieOverviewResponse> getPopularMovies() async {
    String url = Uri.https(
        BASE_URL, "/3/movie/popular", {API_KEY_KEY: TMDB_API_KEY}).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieOverviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<MovieOverviewResponse> getTopRatingMovies() async {
    String url = Uri.https(
        BASE_URL, "/3/movie/top_rated", {API_KEY_KEY: TMDB_API_KEY}).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieOverviewResponse.fromJson(json.decode(response.body));
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

  static Future openIMDBPage(String imdbId) async {
    const url = 'https://www.imdb.com/title/';
    if (await canLaunch(url)) {
      await launch("$url$imdbId");
    } else {
      throw 'Could not launch $url';
    }
  }
}
