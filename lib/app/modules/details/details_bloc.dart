import 'package:bloc/bloc.dart';
import 'package:jungle/app/core/models/movie_model.dart';
import 'package:jungle/app/core/repositories/movie_details_repository.dart';

enum DetailsEvent { loaded }

class DetailsBloc extends Bloc<DetailsEvent, List<MovieModel>> {
  DetailsBloc() : super([]);

  // List<MovieModel> getOtherTrendingMovies(){
  //   MovieDetailsRepository.call(id: id);
  // }

  @override
  Stream<List<MovieModel>> mapEventToState(DetailsEvent event) async* {
    switch (event) {
      case DetailsEvent.loaded:
        yield [];
        break;
    }
  }
}
