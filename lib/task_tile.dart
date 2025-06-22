import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${task.title} deleted')),
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
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: CheckboxListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isChecked
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          value: task.isChecked,
          activeColor: Colors.green[700],
          onChanged: (value) => onToggle(),
        ),
      ),
    );
  }
}
