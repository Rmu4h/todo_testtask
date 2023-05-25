
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

enum TaskType { work, personal }

class Task with ChangeNotifier{
  final String? id;
  final String title;
  TaskType taskType;
  final String description;
  final File? image;
  final DateTime dateTime;
  bool isUrgent;
  bool isCompleted;


  Task({
   required this.id,
   required this.title,
   this.taskType = TaskType.work,
   required this.description,
    this.image,
  required this.dateTime,
   this.isUrgent = false,
    this.isCompleted = false,
  });


  void _setCompletedValue(bool newValue){
    isCompleted = newValue;
    notifyListeners();
  }

  Future<void> toggleCompletedStatus(String? taskId, bool isCompleted) async{
    print('toggleCompletedStatus func work value  ${isCompleted}');

    final oldStatus = isCompleted;
    isCompleted = !isCompleted;
    print('isCompleted value  ${isCompleted}');
    print('this is taskId $taskId');
    final url = Uri.parse(
        'https://flutter-todo-testtask-default-rtdb.firebaseio.com/tasks/$taskId.json');


    try{
      final response = await http.patch(
          url,
          // body: json.encode(
          //   isCompleted,
          // )
        body: '{"isCompleted": $isCompleted}',
      );
      print('isCompleted try work  ${isCompleted}');

      //if something goes wrong, the completed status should remain the old one
      if(response.statusCode >= 400){
        _setCompletedValue(oldStatus);
      }
    }catch(error){
      print('isCompleted error work  ${isCompleted}');

      _setCompletedValue(oldStatus);
    }
  }
}