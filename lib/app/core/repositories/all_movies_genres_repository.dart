import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jungle/app/core/constants/api.dart';

class AllMoviesgenresRepository {
  static Future call() async {
    Dio dio = Dio();

    try {
      Response response = await dio.get(
        '$API_BASE_URL/genre/movie/list?api_key=$API_KEY',
      );

      return response.data['genres'];
    } on DioError catch (error) {
      debugPrint('AllMoviesgenresRepository ERROR: ${error.response}');
      return error.message;
    }
  }
}
