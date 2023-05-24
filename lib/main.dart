import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_testtask/providers/tasks.dart';
import 'package:todo_testtask/screens/auth_screen.dart';
import 'package:todo_testtask/screens/create_task_screen.dart';
import 'package:todo_testtask/screens/edit_task_screen.dart';
import 'package:todo_testtask/screens/tasks_overview_screen.dart';

void main() {
  // Intl.defaultLocale = 'en'; // Set the default locale
  // initializeDateFormatting('uk'); // Initialize Ukrainian locale

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Tasks(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('uk'), // Spanish
        ],
        theme: ThemeData(

          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFFFD600),
            // secondary: const Color(0xFF0A2A3F),
            secondary: const Color(0xFF383838),
          ),
          // buttonTheme: ButtonThemeData(
          //   buttonColor: const Color(0xffff914d), // Background color (orange in my case).
          //   textTheme: ButtonTextTheme.accent,
          //   ),
          fontFamily: 'SF UI Display',
            tabBarTheme: TabBarTheme(
              labelPadding: EdgeInsets.zero, // Remove default padding around label

              // labelColor: Colors.pink[800],
              unselectedLabelColor: Colors.grey, // Text color for unselected tab
              labelColor: Colors.black, // Text color for selected tab
              indicator: BoxDecoration(
                color: Colors.blue, // Background color for selected tab
              ),
              // Set the background color for unselected tab using a custom child widget
              unselectedLabelStyle: TextStyle(
                color: Colors.white, // Text color for unselected tab
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold, // Text style for selected tab
              ),
              // unselectedTabColor: Colors.red, // Колір фону невибраної вкладки
              //   labelStyle: TextStyle(color: Colors.pink[800]), // color for text
              //   indicator: UnderlineTabIndicator( // color for indicator (underline)
              //       borderSide: BorderSide(color: Colors.greenAccent)),
              //   unselectedLabelColor: Colors.deepOrange,
              // unselectedLabelStyle: TextStyle(
              //     backgroundColor: Colors.greenAccent
              // )
            ),
        ),
        home: const AuthScreen(), //CreateTaskScreen(),   //const AuthScreen(),
        routes: {
          TasksOverviewScreen.routeName: (context) => const TasksOverviewScreen(),
          CreateTaskScreen.routeName: (context) => const CreateTaskScreen(),
          EditTaskScreen.routeName: (context) => const EditTaskScreen(),
        },
      ),
    );
  }
}
