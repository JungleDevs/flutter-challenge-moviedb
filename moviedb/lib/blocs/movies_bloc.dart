import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:moviedb/api.dart';
import 'dart:async';
import 'package:moviedb/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BlocBase {
  Api api = Api();

  List<Movie> movies = [];

  final BehaviorSubject<List<Movie>> _moviesController =
      BehaviorSubject<List<Movie>>();
  Stream get outMovies => _moviesController.stream;

  final BehaviorSubject<List<Movie>> _moviesSearchController =
      BehaviorSubject<List<Movie>>();
  Stream get outSearchMovies => _moviesSearchController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  MoviesBloc() {
    api.getMovies().then((movies) {
      _moviesController.add(movies);
    });
  }

  Future<void> refresh() async {
    _moviesController.add([]);
    api.getMovies().then((movies) {
      _moviesController.add(movies);
    });
  }

  void search(String search) async {
    if (search.isNotEmpty) {
      _moviesSearchController.sink.add([]);
      movies = await api.search(search);
      _moviesSearchController.sink.add(movies);
    }
  }

  @override
  void dispose() {
    _moviesController.close();
    _moviesSearchController.close();
    _searchController.close();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
