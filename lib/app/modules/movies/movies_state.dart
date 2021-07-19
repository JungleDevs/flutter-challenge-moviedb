part of 'movies_cubit.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<TrendingMovieModel> movies;

  MoviesLoaded(this.movies);
}

class MoviesLoading extends MoviesState {
  final List<TrendingMovieModel> oldMovies;
  final bool isFirstFetch;

  MoviesLoading(this.oldMovies, {this.isFirstFetch = false});
}
