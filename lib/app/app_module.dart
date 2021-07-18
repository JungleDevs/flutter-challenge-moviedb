import 'package:flutter_modular/flutter_modular.dart';
import 'package:jungle/app/modules/details/details_bloc.dart';
import 'package:jungle/app/modules/details/details_page.dart';
import 'modules/movies/movies_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DetailsBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: MoviesModule()),
    ChildRoute('/movie_details',
        child: (ctx, args) => DetailsPage(
              movieID: args.data['id'],
              listIndex: args.data['idx'],
            ))
  ];
}
