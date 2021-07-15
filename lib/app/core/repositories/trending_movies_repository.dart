import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jungle/app/core/constants/api.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/core/utils/getGenreNamesFromId.dart';

class TrendingMoviesRepository {
  static Future call([int page = 1]) async {
    Dio dio = Dio();
    int? responseStatusCode;
    List<TrendingMovieModel> trendingList = [];

    try {
      Response response = await dio.get(
        '$TRENDING_URL/movie/week?api_key=$API_KEY&&page=$page',
      );

      for (var movie in response.data['results']) {
        var _movieGenres = await getGenreNamesFromID(movie['genre_ids']);
        TrendingMovieModel trendingMovie = TrendingMovieModel.fromMap(movie);
        trendingList.add(trendingMovie.copyWith(genres: _movieGenres));
      }

      return trendingList;
    } on DioError catch (error) {
      debugPrint('TrendingMoviesRepository ERROR: ${error.response}');
      return responseStatusCode;
    }
  }
}
