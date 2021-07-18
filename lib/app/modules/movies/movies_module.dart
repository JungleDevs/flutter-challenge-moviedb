import 'package:flutter_modular/flutter_modular.dart';

import 'movies_cubit.dart';
import 'movies_page.dart';

class MoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MoviesCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => MoviesPage()),
  ];
}
