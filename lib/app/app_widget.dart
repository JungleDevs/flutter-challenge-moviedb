import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jungle/app/core/repositories/trending_movies_repository.dart';
import 'package:jungle/app/modules/movies/movies_cubit.dart';
import 'package:jungle/app/modules/splash/splash.dart';

class AppWidget extends StatelessWidget {
  final TrendingMoviesRepository repository;

  const AppWidget({
    Key? key,
    required this.repository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Challenge The Movie DB',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MoviesCubit(repository),
        child: SplashPage(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(),
      ),
    );
  }
}
