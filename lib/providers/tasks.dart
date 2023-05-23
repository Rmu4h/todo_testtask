import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_testtask/providers/task.dart';
import 'package:http/http.dart' as http;

class Tasks with ChangeNotifier{
  List<Task> _items= [
    // Task(id: 'i1', title: 'Work task', description: 'create resume', image: image, dateTime: dateTime)
  ];

  Future<void> fetchTasks() async{
    final url = Uri.parse('https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks.json');

    try{
      final response = await http.get(url);
      final List<Task> loadedTasks = [];
      if(json.decode(response.body) == null){
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((taskId, taskData) {
        print('this taskId $taskId');
        loadedTasks.add(Task(id: taskId, title: taskData['title'], description: taskData['description'], image:  taskData['image'], dateTime: taskData['dateTime']));
      });
      _items = loadedTasks;
      notifyListeners();
    } catch(error){
      rethrow;
    }
  }

  Future<void> addTask(Task task) async{
    final url = Uri.parse('https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks.json');

    try{
      final response = await http.post(url,
        body: json.encode({
          'title': task.title,
          'taskType': task.taskType,
          'description': task.description,
          'image': task.image,
          'dateTime': task.dateTime,
          'isUrgent': task.isUrgent
        }));
      final newTask = Task(id: json.decode(response.body)['name'], title: task.title, description: task.description, image: task.image, dateTime: task.dateTime);

      _items.add(newTask);

      notifyListeners();
    }catch(error){
      print('error addTask functions $error');

      rethrow;
    }
  }

  Future<void> updateTask(String? id, Task newTask) async{
    final taskIndex = _items.indexWhere((task) => task.id == id);

    if(taskIndex >=0){
      final url = Uri.parse('https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks/$id.json');

      await http.patch(url, body: json.encode({
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

  Future<void> deleteTask(String id) async{
    final url = Uri.parse('https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks/$id.json');

    final existingTaskIndex = _items.indexWhere((task) => task.id == id);

    Task? existingTask = _items[existingTaskIndex];
    _items.removeAt(existingTaskIndex);
    notifyListeners();
    final response = await http.delete(url);

    if(response.statusCode >= 400){
      _items.insert(existingTaskIndex, existingTask);
      notifyListeners();
    }

    existingTask = null;
  }
}