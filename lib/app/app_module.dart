import 'package:flutter_modular/flutter_modular.dart';
import 'package:jungle/app/modules/details/details_bloc.dart';
import 'package:jungle/app/modules/details/details_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DetailsBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/movie_details',
        child: (ctx, args) => DetailsPage(
              movieID: args.data['id'],
              listIndex: args.data['idx'],
            ))
  ];
}
