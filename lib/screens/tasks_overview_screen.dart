import 'package:flutter/material.dart';


class TasksOverviewScreen extends StatelessWidget {
  static const routeName = '/tasks-overview';


  const TasksOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0x44000000).withOpacity(0),
          elevation: 0,
          title: TabBar(
            indicatorPadding: const EdgeInsets.all(5),
            indicator: BoxDecoration(
              // border: Border.all(color: Color(0xFFFBEFB4)),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFBEFB4),
            ),
            tabs: const [
              Tab(text: 'Усі',),
              Tab(text: 'Робочі',),
              Tab(text: 'Особисті',),
            ],
          ),
        ),
        body: TabBarView(
          children:[
            Container(
              width: double.infinity,
              height: double.infinity,
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
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
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
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
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
            ),

          ]
        ),
      ),
    );
  }
}
