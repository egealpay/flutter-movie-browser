class UpcomingMovies {
  final String title;
  final int id;
  final String posterPath;
  final String overview;

  UpcomingMovies({this.id, this.title, this.overview, this.posterPath});

  factory UpcomingMovies.fromJson(Map<String, dynamic> json) {
    return UpcomingMovies(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["poster_path"]
    );
  }
}
