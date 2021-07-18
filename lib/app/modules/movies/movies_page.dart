import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jungle/app/modules/movies/movies_cubit.dart';
import 'package:jungle/app/widgets/movie_tile/movie_tile_widget.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends ModularState<MoviesPage, MoviesCubit> {
  @override
  void initState() {
    cubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: BlocBuilder(
          bloc: cubit,
          builder: (ctx, idx) {
            return body();
          },
        ),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          itemCount: cubit.trendingMovies.length,
          shrinkWrap: true,
          itemBuilder: (ctx, idx) {
            return MovieTileWidget(
                movie: cubit.trendingMovies[idx], index: idx);
          },
        ),
      ),
    );
  }
}
