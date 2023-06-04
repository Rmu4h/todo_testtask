import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_testtask/providers/tasks.dart';
import 'package:todo_testtask/screens/auth_screen.dart';
import 'package:todo_testtask/screens/create_task_screen.dart';
import 'package:todo_testtask/screens/edit_task_screen.dart';
import 'package:todo_testtask/screens/tasks_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Tasks(),
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('uk'), // Spanish
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFFFD600),
            secondary: const Color(0xFF383838),
          ),
          fontFamily: 'SF UI Display',
          tabBarTheme: const TabBarTheme(
            labelPadding: EdgeInsets.zero,
            labelColor: Color(0xFF383838), // Text color for selected tab
          ),
        ),
        home: const AuthScreen(),
        //CreateTaskScreen(),   //const AuthScreen(),
        routes: {
          TasksOverviewScreen.routeName: (context) =>
              const TasksOverviewScreen(),
          CreateTaskScreen.routeName: (context) => const CreateTaskScreen(),
          EditTaskScreen.routeName: (context) => const EditTaskScreen(),
        },
      ),
    );
  }
}
