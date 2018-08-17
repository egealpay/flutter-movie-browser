import 'package:flutter/material.dart';

import 'package:flutter_movie_browser/util/strings.dart';

import 'package:flutter_movie_browser/ui/navdraweritemscreens/favorites_screen.dart';
import 'package:flutter_movie_browser/ui/navdraweritemscreens/settings_screen.dart';
import 'package:flutter_movie_browser/ui/navdraweritemscreens/licences_screen.dart';

import 'package:flutter_movie_browser/ui/tab/now_playing_tab.dart';
import 'package:flutter_movie_browser/ui/tab/popular_tab.dart';
import 'package:flutter_movie_browser/ui/tab/top_rating_tab.dart';
import 'package:flutter_movie_browser/ui/tab/upcoming_tab.dart';

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
                  UpcomingTab(),
                  NowPlayingTab(),
                  PopularTab(),
                  TopRatingTab()
                ]),
              )),
        ));
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
      BuildContext context, Widget screen) {
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
