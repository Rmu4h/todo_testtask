import 'package:flutter/material.dart';
import 'package:todo_testtask/screens/auth_screen.dart';
import 'package:todo_testtask/screens/create_task_screen.dart';
import 'package:todo_testtask/screens/edit_task_screen.dart';
import 'package:todo_testtask/screens/tasks_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFFD600),
          // secondary: const Color(0xFF0A2A3F),
          secondary: Colors.deepOrange,
        ),
        // buttonTheme: ButtonThemeData(
        //   buttonColor: const Color(0xffff914d), // Background color (orange in my case).
        //   textTheme: ButtonTextTheme.accent,
        //   ),
        fontFamily: 'Lato',
          tabBarTheme: TabBarTheme(
              labelColor: Colors.pink[800],
              labelStyle: TextStyle(color: Colors.pink[800]), // color for text
              indicator: UnderlineTabIndicator( // color for indicator (underline)
                  borderSide: BorderSide(color: Colors.greenAccent))),
          primaryColor: Colors.pink[800], // outdated and has no effect to Tabbar
          accentColor: Colors.cyan[600] // deprecated,

      ),
      home: const AuthScreen(),
      routes: {
        TasksOverviewScreen.routeName: (context) => const TasksOverviewScreen(),
        CreateTaskScreen.routeName: (context) => const CreateTaskScreen(),
        EditTaskScreen.routeName: (context) => const EditTaskScreen(),
      },
    );
  }
}
