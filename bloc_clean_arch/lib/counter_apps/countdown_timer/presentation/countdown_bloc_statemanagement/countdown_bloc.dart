import 'dart:ffi';

import 'package:bloc_clean_arch/counter_apps/countdown_timer/presentation/countdown_bloc_statemanagement/count_down_event.dart';
import 'package:bloc_clean_arch/counter_apps/countdown_timer/presentation/countdown_bloc_statemanagement/count_down_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownBloc extends Bloc<CountDownEvent, CountDownState> {
  CountDownBloc() : super(const CountDownState(counter: 0, isCounting: false)) {
    //emit(Counter(counter: 0));
    on<InitializeCountDown>((event, emit) {});
    on<StartCountDown>((event, emit) async {
      // emit(CountDownState(counter: 0));
      print('in Start count');
      for (var i = event.countUntill; i >= 0; i--) {
        await Future.delayed(Duration(seconds: 1));
        emit(CountDownState(counter: i, isCounting: true));
        print(i);
        if (i == 0) {
          emit(CountDownState(counter: i, isCounting: false));
        }
      }
    });
  }
}
