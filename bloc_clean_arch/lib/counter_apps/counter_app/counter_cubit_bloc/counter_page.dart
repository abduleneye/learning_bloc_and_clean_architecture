/*
  COUNTER PAGE: responsible for providing CounterCubit to CounterView (UI)

- use BlocProvider
*/

import 'package:bloc_clean_arch/counter_apps/counter_app/counter_cubit_bloc/counter_cubit_bloc.dart';
import 'package:bloc_clean_arch/counter_apps/counter_app/counter_cubit_bloc/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    //bloc provider
    return BlocProvider(
      create: (context) => CounterCubit(0),
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          //show pop up box when it reaches 10
          if (state == 10) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      content: Text("10 reachead!"),
                    ));
          }
        },
        child: const CounterView(),
      ),
    );
  }
}
