import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/task.dart';
 
part 'todo.g.dart';

@JsonSerializable()
class TodoList{
  List<Task> tasks;

  TodoList(this.tasks);

  Task getTask(int index){
    return tasks[index];
  }

  String getTaskTitle(int index){
    return tasks[index].title;
  }

  bool getTaskStatus(int index){
    return tasks[index].isChecked;
  }

  void addTask(dynamic value){
    if(value is Task){
      tasks.add(value);
    }
    else if(value is String){
      tasks.add(Task(value, false));
    }
  }

  List<String> getTasksTitle(){
    return [for (Task task in tasks) task.title];
  }

  int length(){ return tasks.length;}

  void removeTask(int index){
    tasks.removeAt(index);
  }

  void clear(){
    tasks.clear();
  }

  factory TodoList.fromJson(Map<String, dynamic> json) => _$TodoListFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListToJson(this);

}