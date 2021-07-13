class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final List genreIds;
  final double voteAverage;
  final DateTime releaseDate;
  final List genres;

  Movie(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.backdropPath,
      required this.overview,
      required this.genreIds,
      required this.voteAverage,
      required this.releaseDate,
      required this.genres});

  factory Movie.fromJson(Map<String, dynamic> json, List genres) {
    DateTime dateTime = DateTime.now();
    try {
      dateTime = DateTime.parse(json['release_date']);
    } catch (e) {
      Exception(e);
    }
    List genresMovie = [];
    for (Map genre in genres) {
      for (int genreId in json['genre_ids']) {
        if (genre['id'] == genreId) {
          genresMovie.add(genre['name']);
        }
      }
    }
    return Movie(
        id: json["id"],
        title: json['title'],
        posterPath: json['poster_path'] != null ? json['poster_path'] : '',
        backdropPath:
            json['backdrop_path'] != null ? json['backdrop_path'] : '',
        overview: json['overview'],
        genreIds: json['genre_ids'],
        voteAverage: json['vote_average'] + 0.0,
        releaseDate: dateTime,
        genres: genresMovie);
  }
}
