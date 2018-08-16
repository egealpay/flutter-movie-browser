import 'package:flutter/material.dart';
import 'package:flutter_movie_browser/util/strings.dart';
import 'package:flutter_movie_browser/ui/navdraweritemscreens/FavoritesScreen.dart';
import 'package:flutter_movie_browser/ui/navdraweritemscreens/SettingsScreen.dart';
import 'package:flutter_movie_browser/ui/navdraweritemscreens/LicencesScreen.dart';
import 'package:flutter_movie_browser/ui/moviedetails/MovieDetailsScreen.dart';
import 'package:flutter_movie_browser/network/response/upcoming/UpcomingMoviesResponse.dart';
import 'package:flutter_movie_browser/network/response/upcoming/UpcomingMovies.dart';
import 'package:flutter_movie_browser/network/Requests.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MovieBrowserApp());

class MovieBrowserApp extends StatefulWidget {
  @override
  _MovieBrowserAppState createState() => _MovieBrowserAppState();
}

class _MovieBrowserAppState extends State<MovieBrowserApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movie Browser",
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
              drawer: NavigationDrawer(),
              appBar: AppBar(
                title: Text("Movie Browser"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
                bottom: TabBar(tabs: [
                  Tab(text: "Upcoming"),
                  Tab(text: "Now Playing"),
                  Tab(text: "Popular"),
                  Tab(text: "Top Rating")
                ]),
              ),
              body: Container(
                child: TabBarView(children: [

                  FutureBuilder<UpcomingMoviesResponse>(
                      future: Requests.getUpcomingMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error Occured");
                        }
                        return snapshot.hasData
                            ? UpcomingsListView(
                                snapshot.data.upcomingMoviesList)
                            : Center(child: CircularProgressIndicator());
                      }),

                  FutureBuilder<UpcomingMoviesResponse>(
                      future: Requests.getNowPlayingMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error Occured");
                        }
                        return snapshot.hasData
                            ? UpcomingsListView(
                            snapshot.data.upcomingMoviesList)
                            : Center(child: CircularProgressIndicator());
                      }),

                  FutureBuilder<UpcomingMoviesResponse>(
                      future: Requests.getPopularMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error Occured");
                        }
                        return snapshot.hasData
                            ? UpcomingsListView(
                            snapshot.data.upcomingMoviesList)
                            : Center(child: CircularProgressIndicator());
                      }),

                  FutureBuilder<UpcomingMoviesResponse>(
                      future: Requests.getTopRatingMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error Occured");
                        }
                        return snapshot.hasData
                            ? UpcomingsListView(
                            snapshot.data.upcomingMoviesList)
                            : Center(child: CircularProgressIndicator());
                      }),

                ]),
              )),
        ));
  }
}

class UpcomingsListView extends StatelessWidget {
  List<UpcomingMovies> upcomingMoviesList = <UpcomingMovies>[];

  UpcomingsListView(this.upcomingMoviesList);

  @override
  Widget build(BuildContext context) {
    final Iterable<Container> customListRow =
        upcomingMoviesList.map((UpcomingMovies movie) {
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

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          NavigationDrawerHeader(),
          listTileFactory(
              Icons.favorite, Strings.favorites, context, FavoritesScreen()),
          listTileFactory(
              Icons.settings, Strings.settings, context, SettingsScreen()),
          listTileFactory(
              Icons.drag_handle, Strings.licence, context, LicencesScreen())
        ],
      ),
    );
  }

  ListTile listTileFactory(IconData iconData, String title,
      BuildContext context, StatelessWidget screen) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }
}

class NavigationDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset("images/Brad_Pitt.jpg", height: 96.0, fit: BoxFit.cover),
          Text(
            Strings.header_name,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            Strings.header_email,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
