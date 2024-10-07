/*

TO DO MODEL
This is what a todo object is.
-------------------------------------
It has these properties:

-id
-text
-isCompleted

------------------------------------
Methods:
- toogle completion on &  off
*/

class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  Todo toggleCompletion() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }
}
