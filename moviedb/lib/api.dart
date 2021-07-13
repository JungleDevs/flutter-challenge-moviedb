import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviedb/models/movie.dart';

const API_KEY = '2bca0ca4a908287a062d7355230baae7';

class Api {
  Future<List<Movie>> search(String search) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language=en-US&query=$search&page=1&include_adult=false"));

    return decodeMovies(response);
  }

  Future<List<Movie>> getMovies() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/week?api_key=$API_KEY"));

    if (response.statusCode == 200) {
      return decodeMovies(response);
    } else {
      throw Exception('Failed to get movies.');
    }
  }

  Future<List> getGenres() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$API_KEY&language=en-US"));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return decoded['genres'];
    } else {
      throw Exception('Failed to get genres.');
    }
  }

  Future<List<Movie>> decodeMovies(http.Response response) async {
    var decoded = json.decode(response.body);

    List genres = await getGenres();

    List<Movie> movies = decoded["results"].map<Movie>((map) {
      return Movie.fromJson(map, genres);
    }).toList();

    return movies;
  }
}
