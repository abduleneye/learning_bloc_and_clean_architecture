import 'package:bloc_clean_arch/api_apps/movie_api_call/data/local/movies_api_request_repo_implementation.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movie_screen.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_bloc.dart';
import 'package:bloc_clean_arch/counter_apps/core/presentation/views/counter_apps_home.dart';
import 'package:bloc_clean_arch/quiz_app/data/local/quiz_repo_implementation.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_repo.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_home_screen.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/social_app.dart';
import 'package:bloc_clean_arch/todo_apps/core/presentation/views/todo_apps_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAppsHomeScreen extends StatefulWidget {
  const AllAppsHomeScreen({super.key});

  @override
  State<AllAppsHomeScreen> createState() => _AllAppsHomeScreenState();
}

class _AllAppsHomeScreenState extends State<AllAppsHomeScreen> {
  final movieRepo = MoviesApiRequestRepoImplementation();

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      appBar: AppBar(
        title: const Text(
          'A l l  A P P S',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SocialApp()));
                        },
                        id: 'SOCIAL APP'),
                    MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MySimpleCalcView()));
                        },
                        id: 'CALC APPS'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(onTap: () {}, id: 'IOT APPS '),
                    MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const QuizHomeScreen()));
                        },
                        id: 'QUIZ APP'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            MoviesBloc(movieRepo),
                                        child: const MovieScreen(),
                                      )));
                        },
                        id: 'API APPS'),
                    MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodoAppsHome()));
                        },
                        id: 'TODO APP'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CounterApps()));
                        },
                        id: 'COUNT APP'),
                    MyButton(onTap: () {}, id: 'NAN'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
