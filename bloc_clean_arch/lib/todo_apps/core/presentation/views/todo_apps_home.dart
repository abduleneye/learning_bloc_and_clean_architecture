import 'package:bloc_clean_arch/api_apps/movie_api_call/data/local/movies_api_request_repo_implementation.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/data/local/model/isar_todo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/data/repository/isar_todo_repo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/repoistory/todo_repo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/presentation/todo_cubit.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/presentation/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class TodoAppsHome extends StatefulWidget {
  const TodoAppsHome({super.key});

  @override
  State<TodoAppsHome> createState() => _TodoAppsHomeState();
}

class _TodoAppsHomeState extends State<TodoAppsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'T O D O  A P P S',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                  onTap: () async {
                    //get directory path for storing the data

                    final dir = await getApplicationDocumentsDirectory();
                    // open isar db
                    final isar_as_db =
                        await Isar.open([TodoIsarSchema], directory: dir.path);
                    final todoRepo = IsarTodoRepo(isar_as_db);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => TodoCubit(todoRepo),
                                  child: const TodoView(),
                                )));
                  },
                  id: 'TODO ISAR'),
              MyButton(onTap: () {}, id: 'TODO NAN'),
            ],
          ),
        ]));
  }
}
