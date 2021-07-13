import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/blocs/movies_bloc.dart';
import 'package:moviedb/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => MoviesBloc())],
      dependencies: [],
      child: MaterialApp(
        title: 'Top Movies',
        theme: ThemeData(
            fontFamily: GoogleFonts.getFont('Inter').fontFamily,
            primaryColor: Color.fromARGB(255, 7, 8, 24),
            brightness: Brightness.dark,
            backgroundColor: Color.fromARGB(255, 27, 28, 42),
            accentColor: Color.fromARGB(255, 0, 124, 255)),
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
