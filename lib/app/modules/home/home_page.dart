import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jungle/app/core/constants/api.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/core/repositories/trending_movies_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TrendingMovieModel> trendingMovies = [];

  void init() async {
    try {
      trendingMovies.addAll(await TrendingMoviesRepository.call());
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    setState(() {
      init();
    });

    super.initState();
  }

  var bg_color = Color(0xFF070818);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        title: Text(
          'Top Movies',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          Icon(
            Icons.search_rounded,
            color: Color(0xFFCDCED1),
          ),
        ],
      ),
      body: Center(
        child: body(),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          itemCount: trendingMovies.length,
          itemBuilder: (ctx, idx) {
            return movieTile(movie: trendingMovies[idx], topMovie: idx == 0);
          },
        ),
      ),
    );
  }

  Widget movieTile({
    required TrendingMovieModel movie,
    required bool topMovie,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      height: 168,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: topMovie ? Color(0xFF007CFF) : Color(0xFF1B1C2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 118,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage('$BASE_IMAGE_URL/w200/${movie.poster_image}'),
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
                    visible: topMovie,
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
                        Text(
                          'Top movie this week',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: topMovie ? 8 : 0,
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
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color:
                              topMovie ? Color(0xFF1F8CFF) : Color(0xFF252634),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(
                              5,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 3,
                                ),
                                child: Icon(
                                  index >= movie.rating.ceil() ~/ 2
                                      ? Icons.star_border
                                      : Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 6,
                              ),
                              child: Text(
                                '${movie.rating.ceil() ~/ 2}/5',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFCCE5FF),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
