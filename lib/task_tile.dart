import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;

  const TaskTile({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(task.taskName),
      value: task.isChecked,
      activeColor: Colors.green[700],
      onChanged: onChanged,
    );
  }
}
