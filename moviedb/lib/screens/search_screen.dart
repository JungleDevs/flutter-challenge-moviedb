import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/blocs/movies_bloc.dart';
import 'package:moviedb/widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final moviesBloc = BlocProvider.getBloc<MoviesBloc>();
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                onSubmitted: (text) {
                  moviesBloc.search(text);
                },
              ),
            ),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  moviesBloc.search(textEditingController.text);
                })
          ],
        ),
      ),
      body: StreamBuilder(
        stream: moviesBloc.outSearchMovies,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Center(child: Text('Nenhum resultado encontrado'));
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: snapshot.data[index],
                    index: index,
                    isRanking: false,
                  );
                },
                itemCount: snapshot.data.length,
              );
            }
          } else {
            return Center(child: Text('Digite algo para pesquisar'));
          }
        },
      ),
    );
  }
}
