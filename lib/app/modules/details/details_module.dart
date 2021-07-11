import 'package:jungle/app//modules/details/details_Page.dart';
import 'package:jungle/app//modules/details/details_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DetailsBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DetailsPage()),
  ];
}
