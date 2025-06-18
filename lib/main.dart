import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences? _prefs;

  TodoList tasks = TodoList([
    Task('Phase 1', false),
    Task('HW', false),
    Task('HW2', false)
  ]);

  @override
  void initState(){
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async{
    _prefs = await SharedPreferences.getInstance();
    _getPrefs();
  }

  void _setPrefs(){
    _prefs?.setStringList('tasksTitle', tasks.getTasksTitle());
    var t = tasks.getTasksTitle();
  }

  void _getPrefs(){
    setState(() {
      List<String> taskTitles = _prefs?.getStringList('tasksTitle') ?? [];
    tasks.clear();
    for(String title in taskTitles){
      print(title);
      tasks.addTask(title);
    }});
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
                setState(() {
                  tasks.addTask(Task(taskTitle, false));
                  _setPrefs();
                });
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
          return Dismissible(
            key: UniqueKey(), 
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          tasks.removeTask(index);
          _setPrefs();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${tasks.getTaskTitle(index)} deleted')),
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
              title: Text(tasks.getTaskTitle(index), style: TextStyle(
                decoration: tasks.getTaskStatus(index)
                ? TextDecoration.lineThrough
                : TextDecoration.none
              ),),
              value: tasks.getTaskStatus(index),
              activeColor: Colors.green[700],
              onChanged: (newValue){
                setState(() {
                  tasks.getTask(index).toggleIsChecked();
                });
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