/*
 * TO DO CUBIT = simple state management
 * Each cubit is alist of todos 
 */

import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/models/todo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/repoistory/todo_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<Todo>> {
  //reference todo repo
  final TodoRepo todoRepo;

  //Constructor to intialize the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    //addTodo("INFO");
    loadTodos();
  }

  //LOAD
  Future<void> loadTodos() async {
    //fectch list of todos from repo
    final todoList = await todoRepo.getTodos();

    //emit thr fetched list as a new state
    emit(todoList);
  }

  //ADD
  Future<void> addTodo(String todoText) async {
    // create a new toto wit unique id
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: todoText,
    );

    await todoRepo.addTodo(newTodo);
    loadTodos();
  }

  //DELETE
  Future<void> deleteTodo(Todo todo) async {
    //delete the provided todo
    await todoRepo.deleteTodo(todo);
    //reload
    loadTodos();
  }

  //TOGGLE
  Future<void> toogleTodoCompletion(Todo todo) async {
    //toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    //update the todo in repo with new completion status
    await todoRepo.updateTodo(updatedTodo);

    //reload
    loadTodos();
  }
}
