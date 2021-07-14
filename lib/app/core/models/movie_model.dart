import 'dart:convert';
import 'package:flutter/foundation.dart';

class MovieModel {
  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.release_date,
    required this.poster_image,
    required this.genres,
    overview,
    runtime,
  })  : _overview = overview,
        _runtime = runtime;

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source));

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
        id: map['id'].toInt(),
        title: map['title'],
        rating: map['vote_average'],
        release_date: DateTime.parse(map['release_date']),
        overview: map['overview'],
        poster_image: map['poster_path'],
        runtime: map['runtime']?.toInt(),
        genres: List.of(map['genres'].map((genre) => genre['name'])));
  }

  final List genres;
  final int id;
  final String poster_image;
  final double rating;
  final DateTime release_date;
  final String title;

  final String? _overview;
  final int? _runtime;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieModel &&
        other.title == title &&
        other.rating == rating &&
        other.release_date == release_date &&
        other._overview == _overview &&
        other.poster_image == poster_image &&
        other._runtime == _runtime &&
        listEquals(other.genres, genres);
  }

  @override
  String toString() {
    return 'MovieModel(title: $title, rating: $rating, release_date: $release_date, overview: $_overview, poster_image: $poster_image, runtime: $_runtime, genres: $genres)';
  }

  MovieModel copyWith({
    int? id,
    String? title,
    double? rating,
    DateTime? release_date,
    String? overview,
    String? poster_image,
    int? runtime,
    List<String?>? genres,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      release_date: release_date ?? this.release_date,
      overview: overview ?? _overview,
      poster_image: poster_image ?? this.poster_image,
      runtime: runtime ?? _runtime,
      genres: genres ?? this.genres,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'rating': rating,
      'release_date': release_date,
      'overview': _overview,
      'poster_image': poster_image,
      'runtime': _runtime,
      'genres': genres,
    };
  }
}
