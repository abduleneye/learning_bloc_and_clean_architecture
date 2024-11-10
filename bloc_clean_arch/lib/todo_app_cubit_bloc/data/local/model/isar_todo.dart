import 'package:bloc_clean_arch/todo_app_cubit_bloc/domain/models/todo.dart';
import 'package:isar/isar.dart';

/*
 * ISAR TO DO MODEL
 * converts todo model into isar todo model that we can store in our isar db.
*/

// to generate isar todo object, run: dart run build_runner build
part 'isar_todo.g.dart';

class IdGen {
  static Id _nextId = 1;

  static generateId() {
    return _nextId++;
  }
}

@collection
class TodoIsar {
  Id id = IdGen._nextId;
  late String text;
  late bool isCompleted;

  //convert isar object -> pure todo object to use inn our app
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  // convert pure todo object  -> isar object to store in user db
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
