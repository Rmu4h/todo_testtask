import 'package:flutter/material.dart';

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


    print('task ${widget.task}');
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: widget.task.isUrgent ? const Color(0xFFFF8989) :  const Color(0xFFDBDBDB),
          borderRadius: BorderRadius.circular(15)
        //more than 50% of width makes circle
      ),
      // padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),

      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(EditTaskScreen.routeName,
            // arguments: {
            //  'title': widget.task.title,
            //   'isUrgent': widget.task.isUrgent
            // },
              arguments: Task(
                  id: widget.task.id,
                  title: widget.task.title,
                  taskType: widget.task.taskType,
                  description: widget.task.description,
                  image: widget.task.image,
                  dateTime: widget.task.dateTime,
                  isUrgent: widget.task.isUrgent,

              )
          );
        },
       leading: (widget.task.taskType == TaskType.work) ? const Icon(Icons.work_outline) : const Icon(Icons.home_outlined),
        title: Text(widget.task.title),
        subtitle: Text(widget.task.dateTime.toString()),

        trailing: CustomCheckbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              print('is checked ${isChecked}');
              isChecked = value;
            });
          },
        ),
      ),
    );
  }
}
