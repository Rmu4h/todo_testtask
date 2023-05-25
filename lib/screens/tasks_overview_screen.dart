import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_testtask/screens/create_task_screen.dart';

import '../providers/tasks.dart';
import '../widgets/task_item.dart';

class TasksOverviewScreen extends StatefulWidget {
  static const routeName = '/tasks-overview';

  const TasksOverviewScreen({Key? key}) : super(key: key);

  @override
  State<TasksOverviewScreen> createState() => _TasksOverviewScreenState();
}

class _TasksOverviewScreenState extends State<TasksOverviewScreen>
    with SingleTickerProviderStateMixin {
  var isTabSelected = [true, false, false];
  late final Future _tasksListFuture;
  late TabController _tabController;

  Future _obtainTasksFuture() {
    return Provider.of<Tasks>(context, listen: false).fetchTasks();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _tasksListFuture = _obtainTasksFuture();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<Tasks>(context);
    final tasks = tasksData.tasks;
    final onlyWorkTask = tasksData.onlyWorkList;
    final onlyPersonalTask = tasksData.onlyPersonalList;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 120,
        // Set this height

        automaticallyImplyLeading: false,
        backgroundColor: const Color(0x44000000).withOpacity(0),
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 58.0),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            tabs: [
              GestureDetector(
                onTap: () {
                  if (isTabSelected[0] == false) {
                    setState(() {
                      isTabSelected = [true, false, false];
                    });
                  }
                  _tabController.animateTo(0);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  height: 48,
                  width: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isTabSelected[0] == true
                        ? const Color(0xFFFBEFB4)
                        : const Color(0xFFDBDBDB),
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
                  _tabController.animateTo(1);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  height: 48,
                  width: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isTabSelected[1] == true
                        ? const Color(0xFFFBEFB4)
                        : const Color(0xFFDBDBDB),
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
                  _tabController.animateTo(2);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  height: 48,
                  width: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isTabSelected[2] == true
                        ? const Color(0xFFFBEFB4)
                        : const Color(0xFFDBDBDB),
                  ),
                  child: const Center(child: Text('Особисті')),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: FutureBuilder(
            future: _tasksListFuture,
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${dataSnapshot.error}'),
                  );
                } else {
                  return Consumer<Tasks>(
                    builder: (context, taskData, child) => ListView.builder(
                      itemCount: taskData.tasks.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: tasks[index],
                          child: TaskItem(taskData.tasks[index]),
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Consumer<Tasks>(
              builder: (context, taskData, child) => ListView.builder(
                itemCount: taskData.onlyWorkList.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: onlyWorkTask[index],
                    child: TaskItem(taskData.onlyWorkList[index]),
                  );
                },
              ),
            )),
        Container(
            padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Consumer<Tasks>(
              builder: (context, taskData, child) => ListView.builder(
                itemCount: taskData.onlyPersonalList.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: onlyPersonalTask[index],
                    child: TaskItem(taskData.onlyPersonalList[index]),
                  );
                },
              ),
            )),
      ]),
      floatingActionButton: SizedBox(
        width: 71,
        height: 71,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.of(context).pushNamed(CreateTaskScreen.routeName);
          },
          tooltip: 'Increment',
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
