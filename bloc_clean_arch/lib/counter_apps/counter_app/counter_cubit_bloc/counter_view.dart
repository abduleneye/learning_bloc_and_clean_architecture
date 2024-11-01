/*

COUNTER VIEW: responsible for UI
-use BlockBuilder

 */

import 'package:bloc_clean_arch/counter_apps/counter_app/counter_cubit_bloc/counter_cubit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  //BUILD UI

  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Center(
              child: Text(
            state.toString(),
            style: const TextStyle(
              fontSize: 50,
            ),
          ));
        },
      ),

      //BUTTONS
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //increment
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
            child: const Icon(Icons.add),
          ),
          //decrement
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
