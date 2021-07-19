import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jungle/app/core/constants/api.dart';
import 'package:jungle/app/core/models/movie_model.dart';

class MovieDetailsRepository {
  static Future call({required id}) async {
    Dio dio = Dio();
    int? responseStatusCode;

    try {
      Response response = await dio.get(
        '$BASE_MOVIE_URL/$id?api_key=$API_KEY',
      );

      MovieModel movie = MovieModel.fromMap(response.data);

      return movie;
    } on DioError catch (error) {
      debugPrint('MovieDetailsRepository ERROR: ${error.response}');
      return responseStatusCode;
    }
  }
}
