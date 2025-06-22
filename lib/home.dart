import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/task_dialog.dart';
import 'package:todo_app/task_tile.dart';
import 'package:todo_app/task_storage.dart';




class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TaskStorage _storage = TaskStorage();
  TodoList tasks = TodoList([
    Task('Phase 1', false),
    Task('HW', false),
    Task('HW2', false)
  ]);

  @override
  void initState(){
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final loadedTasks = await _storage.loadTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  void _saveTasks() {
    _storage.saveTasks(tasks);
  }

  void _showDialog(){

    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        onTaskAdded: (taskTitle){
          setState(() {
            tasks.addTask(taskTitle);
            _saveTasks();
          });
        }
      )
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spartans Todo List"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body:  tasks.length() == 0
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
        itemCount: tasks.length(),
        itemBuilder: (context, index){
          return TaskTile(
            task: tasks.getTask(index),
            onDelete: () {
              setState(() {
                tasks.removeTask(index);
                _saveTasks();
              });
            },
            onToggle: () {
              setState(() {
                tasks.getTask(index).toggleIsChecked();
                _saveTasks();
              });
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