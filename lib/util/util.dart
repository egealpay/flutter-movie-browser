import 'package:share/share.dart';

class Utils {

  void shareMovie(String title, String id) {
    Share.share("Check this movie: $title\n https://www.imdb.com/title/$id");
  }

}
