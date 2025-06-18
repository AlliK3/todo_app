void main(){
  
}

class Task{
  String taskTitle;
  bool isChecked = false;

  Task(String this.taskTitle, bool this.isChecked);

  void toggleIsChecked(){
    isChecked = !isChecked;
  }
}

class TodoList{
  List<Task> tasks;

  TodoList(this.tasks);

  Task getTask(int index){
    return tasks[index];
  }

  String getTaskTitle(int index){
    return tasks[index].taskTitle;
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
    return [for (Task task in tasks) task.taskTitle];
  }


  int length(){ return tasks.length;}

  void removeTask(int index){
    tasks.removeAt(index);
  }

  void clear(){
    tasks.clear();
  }
}