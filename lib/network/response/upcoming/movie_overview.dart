class MovieOverview {
  final String title;
  final int id;
  final String posterPath;
  final String overview;

  MovieOverview({this.id, this.title, this.overview, this.posterPath});

  factory MovieOverview.fromJson(Map<String, dynamic> json) {
    return MovieOverview(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["poster_path"]
    );
  }
}
