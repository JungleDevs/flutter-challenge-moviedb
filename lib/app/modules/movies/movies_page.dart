import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/core/utils/no_glowing_overscroll_behavior.dart';
import 'package:jungle/app/modules/movies/movies_cubit.dart';
import 'package:jungle/app/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar_widget.dart';
import 'package:jungle/app/widgets/loading_indicator/loding_indicator_widget.dart';
import 'package:jungle/app/widgets/movie_tile/movie_tile_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final List<IconData> bottomNavigationBarItems = [
    MdiIcons.homeVariantOutline,
    MdiIcons.trophyOutline,
    MdiIcons.movie,
    MdiIcons.chartLine,
  ];

  final ScrollController scrollController = ScrollController();

  final TextEditingController searchController = TextEditingController();

  List<TrendingMovieModel> movies = [];
  @override
  void initState() {
    setupScrollController(context);
    BlocProvider.of<MoviesCubit>(context).loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        setState(() {
          searchController.clear();
        });
        return false;
      }),
      child: Scaffold(
        backgroundColor: Color(0xFF070818),
        appBar: AppBar(
          leadingWidth: 0,
          title: Text(
            searchController.text.isNotEmpty
                ? 'Search: ${searchController.text}'
                : 'Top Movies',
            style: TextStyle(
              fontSize: searchController.text.isNotEmpty ? 18 : 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            searchController.text.isEmpty
                ? searchBar(context)
                : IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                    icon: Icon(Icons.close_rounded))
          ],
        ),
        bottomNavigationBar:
            CustomBottomNavigationBarWidget(iconList: bottomNavigationBarItems),
        body: body(),
      ),
    );
  }

  Widget body() {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
      if (state is MoviesLoading && state.isFirstFetch) {
        return LodingIndicatorWidget();
      }

      bool isLoading = false;

      if (state is MoviesLoading) {
        movies = state.oldMovies;
        isLoading = true;
      }
      if (state is MoviesLoaded) {
        movies = state.movies
            .where((movie) => movie.title.toUpperCase().contains(
                  searchController.text.toUpperCase(),
                ))
            .toList();

        return Padding(
          padding: const EdgeInsets.all(24),
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<MoviesCubit>(context).loadMovies();
            },
            child: ScrollConfiguration(
              behavior: NoGlowingOverscrollBehavior(),
              child: ListView.builder(
                controller: scrollController,
                itemCount: movies.length + (isLoading ? 1 : 0),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index < movies.length && searchController.text.isEmpty) {
                    return MovieTileWidget(
                      movie: movies[index],
                      index: index,
                      stackRoutes: true,
                    );
                  } else if (index < movies.length &&
                      searchController.text.isNotEmpty) {
                    return MovieTileWidget(
                      movie: movies[index],
                      index: -1,
                      stackRoutes: true,
                    );
                  } else {
                    Timer(
                        Duration(milliseconds: 30),
                        () => scrollController
                            .jumpTo(scrollController.position.maxScrollExtent));

                    return LodingIndicatorWidget();
                  }
                },
              ),
            ),
          ),
        );
      }

      return LodingIndicatorWidget();
    });
  }

  Widget searchBar(BuildContext context) {
    return AnimSearchBar(
      autoFocus: true,
      closeSearchOnSuffixTap: true,
      color: Colors.transparent,
      textController: searchController,
      width: MediaQuery.of(context).size.width,
      onSuffixTap: () {
        setState(() {
          searchController.clear();
        });
      },
      style: GoogleFonts.inter(color: Color(0xFFCDCED1), fontSize: 16),
      helpText: 'Search a Movie',
    );
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<MoviesCubit>(context).loadMovies();
        }
      }
    });
  }
}
