import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/data/local/model/isar_todo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/data/repository/isar_todo_repo.dart';
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
  Isar? _db;
  late final IsarTodoRepo todoRepo;

  //Convinience function for getting current db
  // Isar _getDataBaseOrThrow() {
  //   final db = _db;
  //   if (db == null) {
  //     throw Exception();
  //   } else {
  //     return db;
  //   }
  // }

  Future<void> _ensureDbIsOpen() async {
    try {
      await openDb();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> openDb() async {
    if (_db != null) {}
    try {
      //late final Isar isar_as_db;

      //get directory path for storing the data
      final dir = await getApplicationDocumentsDirectory();
      // open isar db
      final db = await Isar.open([TodoIsarSchema], directory: dir.path);
      todoRepo = IsarTodoRepo(db);

      _db = db;
    } catch (e) {}
  }

  Future<void> closeDb() async {
    final db = _db;
    if (db == null) {
    } else {
      await db.close();
      _db = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    closeDb();
  }

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
                    await _ensureDbIsOpen();
                    //final db = _getDataBaseOrThrow();
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
