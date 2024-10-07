/*
TO DO PAGE: responsible for providing cubitr to view(UI)
-use BlocProvider
*/
import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/repoistory/todo_repo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/presentation/todo_cubit.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/presentation/todo_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPageProvider extends StatelessWidget {
  final TodoRepo todoRepo;
  const TodoPageProvider({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TodoCubit(todoRepo), child: const TodoView());
  }
}
