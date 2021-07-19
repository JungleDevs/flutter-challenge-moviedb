String convertRuntimeIntoHHMM(int runtime) {
  int hours = runtime ~/ 60;
  int minutes = runtime % 60;

  return '${hours}h ${minutes}m';
}
