import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jungle/app/core/constants/api.dart';
import 'package:jungle/app/core/models/trending_movie_model.dart';
import 'package:jungle/app/core/repositories/trending_movies_repository.dart';
import 'package:jungle/app/widgets/movie_rating/movie_rating_widget.dart';
import 'package:jungle/app/widgets/movie_tile/movie_tile_widget.dart';

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
          shrinkWrap: true,
          itemBuilder: (ctx, idx) {
            return MovieTileWidget(movie: trendingMovies[idx], index: idx);
          },
        ),
      ),
    );
  }
}
