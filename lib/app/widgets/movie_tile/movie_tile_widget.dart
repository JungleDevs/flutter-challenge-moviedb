import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jungle/app/core/constants/api.dart';
import 'package:jungle/app/modules/details/details_page.dart';
import 'package:jungle/app/widgets/movie_rating/movie_rating_widget.dart';

class MovieTileWidget extends StatelessWidget {
  MovieTileWidget({
    Key? key,
    required this.movie,
    required this.index,
  }) : super(key: key);

  final int index;
  final movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Modular.to.pushNamed(
      //   '/movie_details',
      //   arguments: {'id': movie.id, 'idx': index},
      // ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailsPage(movieID: movie.id, listIndex: index)),
        );
      },
      child: Container(
        alignment: Alignment.topLeft,
        height: 168,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: index == 0 ? Color(0xFF007CFF) : Color(0xFF1B1C2A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 118,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      '$BASE_IMAGE_URL/w200/${movie.poster_image}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 16, right: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: index == 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/il_goldmedal_small.svg',
                            semanticsLabel: 'Gold Medal',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              'Top movie this week',
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: index == 0 ? 8 : 0,
                    ),
                    Text(
                      '${movie.title}',
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${movie.genres.reduce((val, e) => '$val / $e')}',
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFFCCE5FF),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${movie.release_date.year}',
                      style: TextStyle(
                        color: Color(0xFFCCE5FF),
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                        child: MovieRatingWidget(
                      rating: movie.rating,
                      topMovie: index == 0,
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
