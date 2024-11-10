// import 'package:flutter/material.dart';

// class QuizHomeScreen extends StatefulWidget {
//   const QuizHomeScreen({super.key});

//   @override
//   State<QuizHomeScreen> createState() => _QuizHomeScreenState();
// }

// class _QuizHomeScreen extends State<QuizHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QuizHomeScreen'),
//       ),
//     );
//   }
// }
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_mode_screen.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/offline_category_screen.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_screen_view.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: BlocConsumer<QuizBloc, QuizStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.currentScreen == 'mode_screen') {
            return const QuizModeHomeScreen();
          } else if (state.currentScreen == 'offline_mode_screen') {
            return const OfflineCategoryScreen();
          } else if (state.currentScreen == 'quiz_screen') {
            return const MyQuizScreen();
          } else {
            return const ConstrainedScaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
