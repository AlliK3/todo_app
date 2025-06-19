import 'dart:convert';

void main(){
  
}

class Task{
  String title;
  bool isChecked = false;

  Task(String this.title, bool this.isChecked);

  void toggleIsChecked(){
    isChecked = !isChecked;
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'isChecked': isChecked,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    json['title'],
    json['isChecked'],
  );
}

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
      print('Here');
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

  String toJsonString() {
  List<Map<String, dynamic>> taskMaps = tasks.map((task) => task.toJson()).toList();
  return jsonEncode(taskMaps);
  }

  factory TodoList.fromJsonString(String jsonString) {
  List<dynamic> taskList = jsonDecode(jsonString);
  List<Task> taskObjects = taskList.map((e) => Task.fromJson(e)).toList();
  return TodoList(taskObjects);
  }

}