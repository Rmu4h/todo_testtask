import 'package:flutter/material.dart';
import 'package:todo_testtask/screens/create_task_screen.dart';

class TasksOverviewScreen extends StatefulWidget {
  static const routeName = '/tasks-overview';

  const TasksOverviewScreen({Key? key}) : super(key: key);

  @override
  State<TasksOverviewScreen> createState() => _TasksOverviewScreenState();
}

class _TasksOverviewScreenState extends State<TasksOverviewScreen> {
  var isTabSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    print('build run');

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 120, // Set this height

          automaticallyImplyLeading: false,
          backgroundColor: const Color(0x44000000).withOpacity(0),
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 58.0),
            child: TabBar(
              // indicatorPadding: const EdgeInsets.all(20),
              indicator: BoxDecoration(
                // border: Border.all(color: Color(0xFFFBEFB4)),
                borderRadius: BorderRadius.circular(25),
                // color: Color(0xFFFBEFB4),
              ),
              // unselectedLabelStyle: TextStyle(
              //   color: Colors.red,
              //   // backgroundColor: Colors.green,
              // ),
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              tabs: [
                GestureDetector(
                  onTap: () {
                    //change first color tab
                    if (isTabSelected[0] == false) {
                      setState(() {
                        isTabSelected = [true, false, false];
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right:10, left: 10),
                    height: 48,
                    width: 106,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Color(0xFFFBEFB4)),
                      borderRadius: BorderRadius.circular(25),
                      color: isTabSelected[0] == true
                          ? Color(0xFFFBEFB4)
                          : Color(0xFFDBDBDB),
                    ),
                    child: const Center(child: Text('Усі')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isTabSelected[1] == false) {
                      setState(() {
                        //change second color tab
                        isTabSelected = [false, true, false];
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right:10, left: 10),
                    height: 48,
                    width: 106,

                    // width: double.infinity,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Color(0xFFFBEFB4)),
                      borderRadius: BorderRadius.circular(25),
                      color: isTabSelected[1] == true
                          ? Color(0xFFFBEFB4)
                          : Color(0xFFDBDBDB),
                    ),
                    child: const Center(child: Text('Робочі')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isTabSelected[2] == false) {
                      setState(() {
                        //change third color tab
                        isTabSelected = [false, false, true];
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right:10, left: 10),
                    height: 48,
                    width: 106,
                    // width: 44,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Color(0xFFFBEFB4)),
                      borderRadius: BorderRadius.circular(25),
                      color: isTabSelected[2] == true
                          ? const Color(0xFFFBEFB4)
                          : const Color(0xFFDBDBDB),
                    ),
                    child: const Center(child: Text('Особисті')),
                  ),
                ),

                //   child: Center(child: Text('Особисті')),),
                // Tab(text: 'Усі',),
                // Container(
                //   color: Colors.blueGrey, // Background color for unselected tab
                //   child: Tab(text: 'Усі'),
                // ),
                // Tab(text: 'Робочі',),
                // Tab(text: 'Особисті',),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14.0,  130.0, 14.0, 31.0),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: const Text('Overview screen'),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: const Text('Overview screen'),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: const Text('Overview screen'),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.of(context).pushNamed(CreateTaskScreen.routeName);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary,),
        ),
      ),
    );
  }
}
