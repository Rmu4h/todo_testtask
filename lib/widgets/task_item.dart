import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';
import '../screens/edit_task_screen.dart';
import 'custom_checkbox.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem(this.task, {Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Task>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color:
              task.isUrgent ? const Color(0xFFFF8989) : const Color(0xFFDBDBDB),
          borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(EditTaskScreen.routeName,
              arguments: Task(
                id: task.id,
                title: task.title,
                taskType: task.taskType,
                description: task.description,
                image: task.image,
                dateTime: task.dateTime,
                isUrgent: task.isUrgent,
              ));
        },
        leading: (task.taskType == TaskType.work)
            ? const Icon(Icons.work_outline)
            : const Icon(Icons.home_outlined),
        title: Text(task.title),
        subtitle: Text(DateFormat.yMd('uk').format(task.dateTime)),
        trailing: Consumer<Task>(
          builder: (context, task, _) => IconButton(
            onPressed: () {
              task.toggleCompletedStatus(task.id);
            },
            icon: CustomCheckbox(
              value: task.isCompleted,
              onChanged: (value) {
                setState(() {
                  task.toggleCompletedStatus(task.id);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
