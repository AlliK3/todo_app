import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/task.dart';
 
part 'todo.g.dart';

@JsonSerializable()
class TodoList {
  final List<Task> tasks;

  TodoList(this.tasks);

  factory TodoList.fromJson(Map<String, dynamic> json) => _$TodoListFromJson(json);
  Map<String, dynamic> toJson() => _$TodoListToJson(this);

  Task getTask(int index) => tasks[index];
  String getTaskTitle(int index) => tasks[index].title;
  bool getTaskStatus(int index) => tasks[index].isChecked;
  List<String> getTasksTitle() => [for (Task task in tasks) task.title];
  int length() => tasks.length;

  TodoList add(Task task) => TodoList([...tasks, task]);

  TodoList remove(int index) {
    final newTasks = List<Task>.from(tasks)..removeAt(index);
    return TodoList(newTasks);
  }

  TodoList clearAll() => TodoList([]);

  TodoList toggle(int index) {
  final updatedTasks = [...tasks];
  updatedTasks[index] = tasks[index].copyWith(
    isChecked: !tasks[index].isChecked,
  );
  return TodoList(updatedTasks);
}
}
