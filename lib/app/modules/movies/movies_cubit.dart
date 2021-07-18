import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/core/repositories/trending_movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.repository) : super(MoviesInitial());

  int page = 1;
  final TrendingMoviesRepository repository;

  void loadMovies() {
    if (state is MoviesLoading) return;

    final currentState = state;

    var oldMovies = <TrendingMovieModel>[];
    if (currentState is MoviesLoaded) {
      oldMovies = currentState.movies;
    }

    emit(MoviesLoading(oldMovies, isFirstFetch: page == 1));

    TrendingMoviesRepository.fetchMovies(page).then((newMovies) {
      page++;

      final movies = (state as MoviesLoading).oldMovies;
      movies.addAll(newMovies);

      emit(MoviesLoaded(movies));
    });
  }
}
