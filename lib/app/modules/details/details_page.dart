import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jungle/app/core/constants/api.dart';
import 'package:jungle/app/core/models/movie_model.dart';
import 'package:jungle/app/core/repositories/movie_details_repository.dart';
import 'package:jungle/app/core/utils/convertRuntimeIntoHHMM.dart';
import 'package:flutter/material.dart';
import 'package:jungle/app/core/utils/getOtherMoviesIndexes.dart';
import 'package:jungle/app/core/utils/no_glowing_overscroll_behavior.dart';
import 'package:jungle/app/modules/movies/movies_cubit.dart';
import 'package:jungle/app/widgets/loading_indicator/loding_indicator_widget.dart';
import 'package:jungle/app/widgets/movie_rating/movie_rating_widget.dart';
import 'package:jungle/app/widgets/movie_tile/movie_tile_widget.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  DetailsPage({
    Key? key,
    required this.movieID,
    required this.listIndex,
  }) : super(key: key);

  MovieModel? movie;
  final int listIndex;
  final int movieID;
  final TextStyle subtitleTextStyle = GoogleFonts.inter(
    color: Color(0xFFCDCED1),
    fontSize: 12,
  );

  @override
  DetailsPageState createState() => DetailsPageState();

  Future<MovieModel> getMovieDetails() async {
    return await MovieDetailsRepository.call(id: movieID);
  }

  void init() async {
    await getMovieDetails();
  }
}

class DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    widget.getMovieDetails().then((value) {
      setState(() {
        widget.movie = value;
      });
    });
    print(widget.listIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF070818),
      appBar: AppBar(
        elevation: 0,
        primary: true,
        leading: BackButton(onPressed: Navigator.of(context).pop),
        backgroundColor: Colors.transparent,
      ),
      body: body(),
    );
  }

  Widget body() {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (_, state) {
      if (state is MoviesInitial) {
        BlocProvider.of<MoviesCubit>(context).loadMovies();
      }
      if (state is MoviesLoaded) {
        return BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoaded) {
              return Stack(
                children: [
                  Opacity(
                    opacity: 0.35,
                    child: Image.network(
                      '$BASE_IMAGE_URL/original/${widget.movie!.poster_image}',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color(0xFF141733).withOpacity(0.01),
                          Color(0xFF090B19).withOpacity(0.88),
                          Color(0xFF090B19).withOpacity(0.92),
                          Color(0xFF090A17),
                        ],
                        stops: [
                          0.25,
                          0.5,
                          0.6,
                          0.7,
                        ],
                      ),
                    ),
                  ),
                  ScrollConfiguration(
                    behavior: NoGlowingOverscrollBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 90, top: 200),
                            child: Visibility(
                              visible: widget.listIndex == 0,
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Top movie of the week',
                                      style: TextStyle(
                                          color: Color(0xFFCDCED1),
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/il_goldmedal_small.svg',
                                          height: 38,
                                          width: 32,
                                          semanticsLabel: 'Gold Medal',
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${widget.movie!.title}',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: widget.listIndex == 0
                                    ? EdgeInsets.only(left: 72)
                                    : EdgeInsets.only(left: 24),
                                child: Visibility(
                                  visible: widget.listIndex != 0,
                                  child: Text(
                                    '${widget.movie!.title}',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: widget.listIndex == 0
                                    ? EdgeInsets.only(left: 72)
                                    : EdgeInsets.only(left: 24),
                                child: Wrap(
                                  children: [
                                    Text(
                                      '${widget.movie!.release_date.year}',
                                      style: widget.subtitleTextStyle,
                                    ),
                                    Text(' • ',
                                        style: widget.subtitleTextStyle),
                                    Text(
                                      '${widget.movie!.genres.reduce((val, e) => '$val / $e')}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: widget.subtitleTextStyle,
                                    ),
                                    Text(' • ',
                                        style: widget.subtitleTextStyle),
                                    Text(
                                      convertRuntimeIntoHHMM(
                                          widget.movie!.runtime!),
                                      style: widget.subtitleTextStyle,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: widget.listIndex == 0
                                    ? EdgeInsets.only(left: 72)
                                    : EdgeInsets.only(left: 24),
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    '${widget.movie!.overview}',
                                    maxLines: 30,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: widget.listIndex == 0
                                    ? EdgeInsets.only(left: 72)
                                    : EdgeInsets.only(left: 24),
                                child: MovieRatingWidget(
                                  rating: widget.movie!.rating,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: widget.listIndex == 0
                                  ? EdgeInsets.only(left: 30, top: 40)
                                  : EdgeInsets.only(left: 24, top: 40),
                              child: Text(
                                'Also trending',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Container(
                              height: 732,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: 4,
                                itemBuilder: (ctx, idx) {
                                  return MovieTileWidget(
                                    stackRoutes: false,
                                    movie: state.movies[getOtherMoviesIndexes(
                                      thisMovieIDX: widget.listIndex + 1,
                                      builderIDX: idx,
                                      moviesListLength: state.movies.length,
                                    )],
                                    index: widget.listIndex + idx + 1,
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return LodingIndicatorWidget();
            }
          },
        );
      }

      return LodingIndicatorWidget();
    });
  }
}
