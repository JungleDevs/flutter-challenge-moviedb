import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class MovieModel {
  MovieModel({
    required this.title,
    required this.rating,
    required this.release_date,
    required this.overview,
    required this.poster_image,
    required this.runtime,
    required this.genres,
  });

  final List genres;
  final String overview;
  final String poster_image;
  final double rating;
  final DateTime release_date;
  final int runtime;
  final String title;

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source));

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
        title: map['title'],
        rating: map['vote_average'],
        release_date: DateTime.parse(map['release_date']),
        overview: map['overview'],
        poster_image: map['poster_path'],
        runtime: map['runtime']?.toInt(),
        genres: List.of(map['genres'].map((e) => e['name'])));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieModel &&
        other.title == title &&
        other.rating == rating &&
        other.release_date == release_date &&
        other.overview == overview &&
        other.poster_image == poster_image &&
        other.runtime == runtime &&
        listEquals(other.genres, genres);
  }

  @override
  String toString() {
    return 'MovieModel(title: $title, rating: $rating, release_date: $release_date, overview: $overview, poster_image: $poster_image, runtime: $runtime, genres: $genres)';
  }

  MovieModel copyWith({
    String? title,
    double? rating,
    DateTime? release_date,
    String? overview,
    String? poster_image,
    int? runtime,
    List<String>? genres,
  }) {
    return MovieModel(
      title: title ?? this.title,
      rating: rating ?? this.rating,
      release_date: release_date ?? this.release_date,
      overview: overview ?? this.overview,
      poster_image: poster_image ?? this.poster_image,
      runtime: runtime ?? this.runtime,
      genres: genres ?? this.genres,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'rating': rating,
      'release_date': release_date,
      'overview': overview,
      'poster_image': poster_image,
      'runtime': runtime,
      'genres': genres,
    };
  }
}
