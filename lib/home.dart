import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/task_dialog.dart';
import 'package:todo_app/task_tile.dart';
import 'package:todo_app/task_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Home extends HookWidget {
  Home({super.key});


  @override
  Widget build(BuildContext context) {
    final TaskStorage _storage = TaskStorage();
    final tasks = useState<TodoList>(TodoList([
      Task('Phase 1', false),
      Task('HW', false),
      Task('HW2', false),
    ]));

    useEffect(() {
        _storage.loadTasks().then((loadedTasks) {
          tasks.value = loadedTasks;
        });
        return null;
      }, []);

  void _saveTasks() {
    _storage.saveTasks(tasks.value);
  }

  void _showDialog(){

    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        onTaskAdded: (taskTitle){
            tasks.value.addTask(taskTitle);
            tasks.value = TodoList([...tasks.value.tasks]);
            _saveTasks();
        }
      )
    );
  }

  
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spartans Todo List"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body:  tasks.value.length() == 0
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No tasks yet!\nTap + to add one.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      )
    : ListView.builder(
        itemCount: tasks.value.length(),
        itemBuilder: (context, index){
          return TaskTile(
            task: tasks.value.getTask(index),
            onDelete: () {
                tasks.value.removeTask(index);
                tasks.value = TodoList([...tasks.value.tasks]);
                _saveTasks();
            },
            onToggle: () {
                tasks.value.getTask(index).toggleIsChecked();
                tasks.value = TodoList([...tasks.value.tasks]);
                _saveTasks();
            },
          );
        }
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add)),
      );
  }
}