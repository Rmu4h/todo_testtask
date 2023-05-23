import 'package:flutter/material.dart';

import '../providers/task.dart';
import 'custom_radio.dart';

// enum TaskType { work, personal }

class RadioInput extends StatefulWidget {
  final TaskType initialValue;
  final void Function(TaskType) onChanged;


  const RadioInput({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  TaskType? taskType = TaskType.work;

  @override
  void initState() {
    super.initState();
    taskType = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 34),
      color: const Color(0xFFFBEFB4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
              title: const Text('Робочі', style: TextStyle(
                  fontSize: 18
              ),),
              leading: InkWell(
                onTap: () {
                  setState(() {
                    taskType = TaskType.work;
                    widget.onChanged(taskType!);
                  });
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBDBDB),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDBDBDB),
                      width: 7.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: taskType == TaskType.work
                        ? Container(
                      // width: 23.0,
                      // height: 23.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFD600),
                      ),
                    )
                        : Container(
                      // width: 23.0,
                      // height: 23.0,
                    ),
                  ),
                ),
              )
            ),
          ),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
              title: const Text('Особисті', style: TextStyle(
                  fontSize: 18
              )),
              leading: InkWell(
                onTap: () {
                  setState(() {
                    taskType = TaskType.personal;
                    widget.onChanged(taskType!);
                  });
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBDBDB),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDBDBDB),
                      width: 7.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: taskType == TaskType.personal
                        ? Container(
                      // width: 23.0,
                      // height: 23.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFD600),
                      ),
                    )
                        : Container(
                      // width: 23.0,
                      // height: 23.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
