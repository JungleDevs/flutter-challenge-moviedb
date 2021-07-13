import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/models/movie.dart';
import 'package:moviedb/screens/detail_movie_screen.dart';
import 'package:moviedb/widgets/rating_widget.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {required this.movie,
      required this.index,
      required this.isRanking,
      Key? key})
      : super(key: key);

  final Movie movie;
  final int index;
  final bool isRanking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailMovieScreen(
                  movie: movie, index: index, isRanking: isRanking)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          color: index == 0 && isRanking
              ? Color.fromARGB(255, 0, 124, 255)
              : Theme.of(context).backgroundColor,
          child: Row(
            children: [
              Container(
                width: 118,
                height: 168,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://www.themoviedb.org/t/p/w342${movie.posterPath}',
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, error, d) {
                      return Center(
                          child: Text(
                        'Não foi possível carregar a imagem',
                        textAlign: TextAlign.center,
                      ));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 168,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index == 0 && isRanking
                                ? Row(
                                    children: [
                                      Container(
                                          height: 24,
                                          child: Image.asset(
                                              'assets/goldmedal_large.png')),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Top movie this week',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 204, 229, 255)),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 0
                                ? SizedBox(
                                    height: 12,
                                  )
                                : Container(),
                            Text(movie.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              width: 200,
                              height: 14,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movie.genreIds.length,
                                  itemBuilder: (context, index) {
                                    if (index == movie.genreIds.length - 1) {
                                      return Text(
                                        '${movie.genres[index]}',
                                        style: buildStyleGenre(movie),
                                      );
                                    } else {
                                      return Text(
                                        '${movie.genres[index]} / ',
                                        style: buildStyleGenre(movie),
                                      );
                                    }
                                  }),
                            ),
                            Text(
                              movie.releaseDate.year.toString(),
                              style: buildStyleGenre(movie),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: RatingTile(
                            movie: movie,
                            index: index,
                            isDetailScreen: false,
                            isRanking: isRanking,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildStyleGenre(Movie movie) {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Color.fromARGB(255, 204, 229, 255));
  }
}
