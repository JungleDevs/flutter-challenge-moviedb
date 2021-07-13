import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/blocs/movies_bloc.dart';
import 'package:moviedb/widgets/movie_card.dart';

class RankingTab extends StatefulWidget {
  RankingTab({Key? key}) : super(key: key);

  @override
  _RankingTabState createState() => _RankingTabState();
}

class _RankingTabState extends State<RankingTab> {
  final moviesBloc = BlocProvider.getBloc<MoviesBloc>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: moviesBloc.refresh,
      child: Column(
        children: [
          StreamBuilder(
              stream: moviesBloc.outMovies,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        return MovieCard(
                          movie: snapshot.data[index],
                          index: index,
                          isRanking: true,
                        );
                      },
                      itemCount: snapshot.data.length,
                    ),
                  );
                } else {
                  return Center(
                    child: RefreshProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
