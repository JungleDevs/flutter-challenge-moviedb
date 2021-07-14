Map<int, String> invertGenresMap(List originalGenresList) {
  Map<int, String> newMap = {};

  for (var i in originalGenresList) {
    newMap[i['id']] = i['name'];
  }
  return newMap;
}
