import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/network/response/upcoming/movie_overview_response.dart';
import 'package:flutter_movie_browser/network/request/requests.dart';
import 'package:flutter_movie_browser/ui/tab/base_tab.dart';

class TopRatingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<MovieOverviewResponse>(
        future: Requests.getTopRatingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Occured");
          }
          return snapshot.hasData
              ? MovieOverviewListView(snapshot.data.movieOverviewList)
              : Center(child: CircularProgressIndicator());
        });
  }
}
