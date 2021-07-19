import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jungle/app/core/repositories/trending_movies_repository.dart';
import 'package:jungle/app/modules/movies/movies_cubit.dart';
import 'package:jungle/app/modules/movies/movies_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<MoviesCubit>.value(
            value: MoviesCubit(TrendingMoviesRepository()),
            child: MoviesPage(),
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF007CFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Image.asset(
            'assets/images/il_splash.png',
            width: 160,
          ),
        ),
      ),
    );
  }
}
