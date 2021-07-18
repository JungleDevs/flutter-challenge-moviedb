import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/modules/movies/movies_cubit.dart';
import 'package:jungle/app/widgets/loading_indicator/loding_indicator_widget.dart';
import 'package:jungle/app/widgets/movie_tile/movie_tile_widget.dart';

class MoviesPage extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<MoviesCubit>(context).loadMovies();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<MoviesCubit>(context).loadMovies();

    return Scaffold(
      backgroundColor: Color(0xFF070818),
      appBar: AppBar(
        title: Text(
          'Top Movies',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          Icon(Icons.search_rounded, color: Color(0xFFCDCED1)),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
      if (state is MoviesLoading && state.isFirstFetch) {
        return LodingIndicatorWidget();
      }

      List<TrendingMovieModel> movies = [];
      bool isLoading = false;

      if (state is MoviesLoading) {
        movies = state.oldMovies;
        isLoading = true;
      } else if (state is MoviesLoaded) {
        movies = state.movies;
      }
      return Padding(
        padding: const EdgeInsets.all(24),
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            controller: scrollController,
            itemCount: movies.length + (isLoading ? 1 : 0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index < movies.length) {
                return MovieTileWidget(movie: movies[index], index: index);
              } else {
                Timer(Duration(milliseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });

                return LodingIndicatorWidget();
              }
            },
          ),
        ),
      );
    });
  }
}
