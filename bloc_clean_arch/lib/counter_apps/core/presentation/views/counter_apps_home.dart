import 'package:bloc_clean_arch/counter_apps/countdown_timer/presentation/count_down_screen.dart';
import 'package:bloc_clean_arch/counter_apps/countdown_timer/presentation/countdown_bloc_statemanagement/countdown_bloc.dart';
import 'package:bloc_clean_arch/counter_apps/counter_app/counter_cubit_bloc/counter_cubit_bloc.dart';
import 'package:bloc_clean_arch/counter_apps/counter_app/counter_cubit_bloc/counter_page.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterApps extends StatefulWidget {
  const CounterApps({super.key});

  @override
  State<CounterApps> createState() => _CounterAppsState();
}

class _CounterAppsState extends State<CounterApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('C O U N T E R  A P P S'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => CountDownBloc(),
                                  child: const CountDownScreen(),
                                )));
                  },
                  id: 'COUNT DOWN APP'),
              MyButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => CounterCubit(0),
                                  child: const CounterPage(),
                                )));
                  },
                  id: 'COUNTER APP'),
            ],
          ),
        ]));
  }
}
