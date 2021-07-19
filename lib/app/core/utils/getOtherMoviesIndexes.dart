int getOtherMoviesIndexes(
    {required int thisMovieIDX,
    required int builderIDX,
    required int moviesListLength}) {
  return (thisMovieIDX + builderIDX + moviesListLength) % moviesListLength;
}
