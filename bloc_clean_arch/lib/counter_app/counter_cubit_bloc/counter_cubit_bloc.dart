/*
CUBIT: Simpified version of Bloc for easy state managment
Let's create our own counter cubit
*/

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  // constructor: to get or accept the initial state
  CounterCubit(super.initialState);

  //increament
  void increment() => emit(state + 1);

  //decrement
  void decrement() => emit(state - 1);

  //on state changed -> do something
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(state);
    print(change);
  }
}
