void main(){
  
}

class Task{
  String taskName;
  bool isChecked = false;

  Task(String this.taskName, bool this.isChecked);

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

  String getTaskName(int index){
    return tasks[index].taskName;
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

  List<String> getTasksList(){
    return [for (Task task in tasks) task.taskName];
  }


  int length(){ return tasks.length;}

  void removeTask(int index){
    tasks.removeAt(index);
  }
}