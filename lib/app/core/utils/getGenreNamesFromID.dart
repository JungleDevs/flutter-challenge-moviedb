import 'package:jungle/app/core/repositories/all_movies_genres_repository.dart';
import 'package:jungle/app/core/utils/invertGenresMap.dart';

Future getGenreNamesFromID(List idList) async {
  List genres = await AllMoviesgenresRepository.call();
  Map<int, String> newGenresMap = invertGenresMap(genres);

  return idList.map((i) => newGenresMap[i]).toList();
}
