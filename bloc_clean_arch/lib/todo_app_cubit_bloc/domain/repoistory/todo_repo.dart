/*

TO DO REPO

HERE YOU DO WHAT THE APP CAN DO

*/

import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/models/todo.dart';

abstract class TodoRepo {
//get list of todos
  Future<List<Todo>> getTodos();
//add a new todo
  Future<void> addTodo(Todo newTodo);
//update an existing todo
  Future<void> updateTodo(Todo todo);
//delete a todo
  Future<void> deleteTodo(Todo todo);
}


/** 
 * Notes: 
 * the repo int the domain layer outlines what the operations the app can do, but doesn't worry about the
 * specific implememntation details, that's for the data layer.
 * 
 * Technology agnostic: independent of any technology of any framework, purel a dart file.
*/