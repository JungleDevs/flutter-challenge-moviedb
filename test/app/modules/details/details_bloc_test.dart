import 'package:bloc_test/bloc_test.dart';
import 'package:jungle/app//modules/details/details_bloc.dart';

void main() {
  blocTest<DetailsBloc, int>(
    'emits [1] when increment is added',
    build: () => DetailsBloc(),
    act: (bloc) => bloc.add(DetailsEvent.increment),
    expect: () => [1],
  );
}
