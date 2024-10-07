/*
TO DO VIEW: Responsible for the UI

- use BlocBuilder
*/

import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/models/todo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/presentation/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});
  // show dialog box for user to type in
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Enter Todo:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  TextField(
                    controller: textController,
                  ),
                ],
              ),
              actions: [
                //cancel button
                TextButton(
                    onPressed: () {
                      //todoCubit.addTodo(textController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),

                // add button
                TextButton(
                    onPressed: () {
                      todoCubit.addTodo(textController.text.toUpperCase());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add')),
              ],
            ));
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('TODO APP'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _showAddTodoBox(context);
          },
        ),
        body: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, todosState) {
            //List View
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: todosState.length,
              itemBuilder: (context, index) {
                //  const Text('Hello');

                //get individual todos from to do list
                final todo = todosState[index];

                //List Tile

                return ListTile(
                  //text
                  title: Text(todo.text),
                  //CheckBox
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) => todoCubit.toogleTodoCompletion(todo),
                  ),

                  //Delete Button
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => todoCubit.deleteTodo(todo),
                  ),
                );
              },
            );
          },
        ));
  }
}
