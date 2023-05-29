import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_testtask/providers/task.dart';
import 'package:http/http.dart' as http;

class Tasks with ChangeNotifier {
  List<Task> _items = [
    // Task(id: 'i1', title: 'Work task', description: 'create resume', image: image, dateTime: dateTime)
  ];

  List<Task> get tasks {
    return [..._items];
  }

  List<Task> get onlyWorkList {
    return _items
        .where((element) => element.taskType == TaskType.work)
        .toList();
  }

  List<Task> get onlyPersonalList {
    return _items
        .where((element) => element.taskType == TaskType.personal)
        .toList();
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
        loadedTasks.add(Task(
            id: taskId,
            title: taskData['title'],
            taskType: parseTaskType(taskData['taskType']),
            description: taskData['description'],
            // image: taskData['image'],
            dateTime: DateTime.parse(taskData['dateTime']),
            isUrgent: taskData['isUrgent'],
            isCompleted: taskData['isCompleted']));
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
      final response = await http.post(url,
          body: json.encode({
            'title': task.title,
            'taskType': task.taskType.toString(),
            'description': task.description,
            'dateTime': task.dateTime.toString(),
            'isUrgent': task.isUrgent,
            'isCompleted': task.isCompleted
          }));

      final newTask = Task(
        id: json.decode(response.body)['name'],
        // id: task.id,
        title: task.title,
        taskType: task.taskType,
        description: task.description,
        dateTime: task.dateTime,
        isUrgent: task.isUrgent,
        isCompleted: task.isCompleted,
      );

      _items.add(newTask);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Task findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> updateTask(String? id, Task newTask) async {
    final taskIndex = _items.indexWhere((task) => task.id == id);

    final url = Uri.parse(
        'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks/$id.json');

    await http.patch(url,
        body: json.encode({
          'title': newTask.title,
          'taskType': newTask.taskType.toString(),
          'description': newTask.description,
          // 'image': newTask.image,
          'dateTime': newTask.dateTime.toString(),
          'isUrgent': newTask.isUrgent,
          'isCompleted': newTask.isCompleted,
        }));

    _items[taskIndex] = newTask;
    notifyListeners();
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
