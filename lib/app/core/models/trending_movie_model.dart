import 'package:jungle/app/core/models/movie_model.dart';

class TrendingMovieModel extends MovieModel {
  TrendingMovieModel(
      {required id,
      required title,
      required rating,
      required release_date,
      required poster_image,
      required genres})
      : super(
            id: id,
            title: title,
            rating: rating,
            release_date: release_date,
            poster_image: poster_image,
            genres: genres);

  factory TrendingMovieModel.fromMap(Map<String, dynamic> map) {
    return TrendingMovieModel(
      id: map['id'].toInt(),
      title: map['title'],
      rating: map['vote_average'],
      release_date: DateTime.parse(map['release_date']),
      poster_image: map['poster_path'],
      genres: [],
    );
  }

  @override
  TrendingMovieModel copyWith({
    int? id,
    String? title,
    double? rating,
    DateTime? release_date,
    String? poster_image,
    List<String?>? genres,

    /* these (overview & runtime) are needed to match the original method signature
    because overloading is not supported in Dart :( 
    */
    String? overview,
    int? runtime,
  }) {
    return TrendingMovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      release_date: release_date ?? this.release_date,
      poster_image: poster_image ?? this.poster_image,
      genres: genres ?? this.genres,
    );
  }
}
