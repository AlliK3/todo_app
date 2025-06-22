import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  final Function(String) onTaskAdded;

  const TaskDialog({super.key, required this.onTaskAdded});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final TextEditingController _textController = TextEditingController();

  void _submit() {
    String taskTitle = _textController.text.trim();
    if (taskTitle.isNotEmpty) {
      widget.onTaskAdded(taskTitle);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new task'),
      content: TextField(
        controller: _textController,
        decoration: const InputDecoration(hintText: 'Enter new task title'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        TextButton(onPressed: _submit, child: const Text('Add'))
      ],
    );
  }
}
