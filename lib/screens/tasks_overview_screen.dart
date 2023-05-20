import 'package:flutter/material.dart';


class TasksOverviewScreen extends StatelessWidget {
  static const routeName = '/tasks-overview';


  const TasksOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA9A9A9),
              Color(0xFF383838)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: const Text('Overview screen'),
    );
  }
}
