import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_testtask/providers/task.dart';
import 'package:http/http.dart' as http;

class Tasks with ChangeNotifier {
  List<Task> _items = [
    // Task(id: 'i1', title: 'Work task', description: 'create resume', image: image, dateTime: dateTime)
  ];

  List<Task> get tasks{
    return [..._items];
  }

  List<Task> get onlyWorkList {
    return _items.where((element) => element.taskType == TaskType.work).toList();
  }

  List<Task> get onlyPersonalList {
    return _items.where((element) => element.taskType == TaskType.personal).toList();
  }

  TaskType parseTaskType(String value) {
    final enumString = value.split('.').last;
    return TaskType.values.firstWhere(
          (type) => type.toString().split('.').last == enumString,

    );
  }

  Future<void> fetchTasks() async {
    final url = Uri.parse(
        'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks.json');

    try {
      final response = await http.get(url);
      final List<Task> loadedTasks = [];
      if (json.decode(response.body) == null) {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((taskId, taskData) {
        print('this is dateTime ${taskData['dateTime']}');
        print('this taskId $taskId');
        loadedTasks.add(Task(
            id: taskId,
            title: taskData['title'],
            taskType: parseTaskType(taskData['taskType']),
            description: taskData['description'],
            // image: taskData['image'],
            dateTime: DateTime.parse(taskData['dateTime']),
            isUrgent: taskData['isUrgent'],
        ));
      });
      _items = loadedTasks;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addTask(Task task) async {
    final url = Uri.parse(
        'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks.json');


    try {
      var response = await http.post(url,
          body: json.encode({
            'title': task.title,
            'taskType': task.taskType.toString(),
            'description': task.description,
            'dateTime': task.dateTime.toString(),
            'isUrgent': task.isUrgent
          })
      );
      final newTask = Task(
          id: DateTime.now().toString(),
          title: task.title,
          taskType: task.taskType,
          description: task.description,
          // image: task.image,
          dateTime: task.dateTime,
          isUrgent: task.isUrgent,
      );

      _items.add(newTask);

      notifyListeners();
    } catch (error) {
      print('error addTask functions $error');

      rethrow;
    }
  }

  // void addTask(Task task){
  //   final url = Uri.parse(
  //       'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks.json');
  //
  //   print('add task work');
  //
  //   final taskTest = {
  //     'title': task.title,
  //     // 'taskType': task.taskType,
  //     'description': task.description,
  //     'dateTime': task.dateTime.toString(),
  //     'isUrgent': task.isUrgent,
  //   };
  //
  //   print('this is taskTest values ${taskTest.values}');
  //
  //   http.post(url,
  //       body: json.encode(taskTest),
  //   );
  //
  //   final newTask = Task(
  //           id: DateTime.now().toString(),
  //     title: task.title,
  //     taskType: task.taskType,
  //     description: task.description,
  //     // image: task.image,
  //     dateTime: task.dateTime,
  //     isUrgent: task.isUrgent,
  //   );
  //
  //   _items.add(newTask);
  //
  //   notifyListeners();
  // }

  Future<void> updateTask(String? id, Task newTask) async {
    final taskIndex = _items.indexWhere((task) => task.id == id);

    if (taskIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks/$id.json');

      await http.patch(url,
          body: json.encode({
            'title': newTask.title,
            'taskType': newTask.taskType,
            'description': newTask.description,
            'image': newTask.image,
            'dateTime': newTask.dateTime,
            'isUrgent': newTask.isUrgent,
          }));

      _items[taskIndex] = newTask;
      notifyListeners();
    } else {
      print('....');
    }
  }

  Future<void> deleteTask(String id) async {
    final url = Uri.parse(
        'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks/$id.json');

    final existingTaskIndex = _items.indexWhere((task) => task.id == id);

    Task? existingTask = _items[existingTaskIndex];
    _items.removeAt(existingTaskIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingTaskIndex, existingTask);
      notifyListeners();
    }

    existingTask = null;
  }
}
