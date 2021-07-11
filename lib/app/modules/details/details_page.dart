import 'package:flutter_modular/flutter_modular.dart';
import 'package:jungle/app//modules/details/details_bloc.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  const DetailsPage({Key? key, this.title = 'DetailsPage'}) : super(key: key);
  @override
  DetailsPageState createState() => DetailsPageState();
}
class DetailsPageState extends State<DetailsPage> {
  final DetailsBloc bloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}