import 'package:flutter/material.dart';

import 'package:flutter_movie_browser/network/response/detail/genre.dart';

class GenresWidget extends StatelessWidget{
  final List<Genre> genreList;

  GenresWidget(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
            getGenres(genreList)
        ),
        margin: EdgeInsets.only(bottom: 8.0)
    );
  }

  String getGenres(List<Genre> genreList) {
    String genres = "| ";

    genreList.forEach(
            (genre) => genres += genre.toString() + " | "
    );

    return genres;
  }
}