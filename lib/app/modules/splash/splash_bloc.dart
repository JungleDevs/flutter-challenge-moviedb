import 'package:bloc/bloc.dart';

enum SplashEvent {increment}

class SplashBloc extends Bloc<SplashEvent, int> {
  SplashBloc() : super(0);

  @override
  Stream<int> mapEventToState(SplashEvent event) async* {
    switch (event) {
      case SplashEvent.increment:
        yield state + 1;
        break;
    }
  }
}