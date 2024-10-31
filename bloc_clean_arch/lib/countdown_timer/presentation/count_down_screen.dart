import 'package:bloc_clean_arch/countdown_timer/presentation/countdown_bloc_statemanagement/count_down_event.dart';
import 'package:bloc_clean_arch/countdown_timer/presentation/countdown_bloc_statemanagement/count_down_state.dart';
import 'package:bloc_clean_arch/countdown_timer/presentation/countdown_bloc_statemanagement/countdown_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownScreen extends StatefulWidget {
  const CountDownScreen({super.key});

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  final countDownTextController = TextEditingController();

  @override
  void dispose() {
    countDownTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COUNT DOWN'),
      ),
      body: BlocBuilder<CountDownBloc, CountDownState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextField(
                    controller: countDownTextController,
                  ),
                ),
                Text(state.counter.toString()),
                IconButton(
                    onPressed: () {
                      context.read<CountDownBloc>().add(StartCountDown(
                          countUntill:
                              int.parse(countDownTextController.text)));
                    },
                    icon: Icon(
                        state.isCounting ? Icons.pause : Icons.play_arrow)),
                //IconButton(onPressed: () {}, icon: const Icon(Icons.pause))
              ],
            ),
          );
        },
      ),
    );
  }
}
