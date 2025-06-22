import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


void main() {
  runApp( MaterialApp(
    home: Home()
  ));
}

class Home extends HookWidget {
  Home({super.key});
  
  @override
  Widget build(BuildContext context) {

    final tasks = useState(
      TodoList([
        Task('Phase 1', false),
        Task('HW', false),
        Task('HW2', false),
      ])
      );

      useEffect(() {
        Future<void> _initPrefs() async {
          final prefs = await SharedPreferences.getInstance();
          final jsonString = prefs.getString('tasks');
          if (jsonString != null) {
            final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
            tasks.value = TodoList.fromJson(jsonMap);
          }
        }

        _initPrefs();

        return null;
      }, []);

    void _setPrefs() async {
      final prefs = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(tasks.value.toJson());
      prefs.setString('tasks', jsonString);
    }

    void _showDialog(){
    TextEditingController _textController = TextEditingController();
  
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Add new task'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter new task title'
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')
              ),
            TextButton(
              onPressed: (){
                String taskTitle = _textController.text.trim();
              if (taskTitle.isNotEmpty) {
                  tasks.value = tasks.value.add(Task(taskTitle, false));
                  _setPrefs();
              }
              Navigator.of(context).pop();
              },
               child: const Text('Add')
              )
          ],
        );
       }
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
          return Dismissible(
            key: UniqueKey(), 
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
          final deletedTitle = tasks.value.getTaskTitle(index);
          tasks.value = tasks.value.remove(index);
          _setPrefs();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$deletedTitle deleted')),
          );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
            child: Container(
            decoration: BoxDecoration(
              color: Colors.green[200],
              border: Border.all(width: 1.5),
              borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: CheckboxListTile(
              title: Text(tasks.value.getTaskTitle(index), style: TextStyle(
                decoration: tasks.value.getTaskStatus(index)
                ? TextDecoration.lineThrough
                : TextDecoration.none
              ),),
              value: tasks.value.getTaskStatus(index),
              activeColor: Colors.green[700],
              onChanged: (newValue){
                  tasks.value = tasks.value.toggle(index);
                  _setPrefs();
              },
            ),
          ),
          );
        }
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add)),
      );
  }
}
