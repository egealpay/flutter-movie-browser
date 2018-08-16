import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movie_browser/util/strings.dart';

class AdditionalInfoWidget extends StatelessWidget {
  final String posterPath;
  final String releaseDate;
  final String runtime;
  final String budget;

  AdditionalInfoWidget(this.posterPath, this.releaseDate, this.runtime, this.budget);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500/$posterPath",
                fit: BoxFit.fill),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        generateRow(Strings.released, releaseDate),
                        generateRow(
                            Strings.runtime, runtime),
                        generateRow(
                            Strings.budget, budget)
                      ],
                    )))
          ],
        ));
  }

  Row generateRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text(key), Text(value)],
    );
  }
}
