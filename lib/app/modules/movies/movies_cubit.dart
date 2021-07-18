import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/core/repositories/trending_movies_repository.dart';

enum DetailsEvent { loading }

class MoviesCubit extends Cubit<List<TrendingMovieModel>> {
  MoviesCubit() : super([]);

  List<TrendingMovieModel> trendingMovies = [];

  void getTopMovies() => emit(trendingMovies);

  void init() async {
    trendingMovies = await TrendingMoviesRepository.call();
  }
}
