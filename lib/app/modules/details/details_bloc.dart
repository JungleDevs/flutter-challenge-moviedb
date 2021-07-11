import 'package:bloc/bloc.dart';

enum DetailsEvent {increment}

class DetailsBloc extends Bloc<DetailsEvent, int> {
  DetailsBloc() : super(0);

  @override
  Stream<int> mapEventToState(DetailsEvent event) async* {
    switch (event) {
      case DetailsEvent.increment:
        yield state + 1;
        break;
    }
  }
}