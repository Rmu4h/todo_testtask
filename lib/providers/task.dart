
import 'dart:io';

import 'package:flutter/material.dart';

enum TaskType { work, personal }

class Task with ChangeNotifier{
  final String? id;
  final String title;
  final TaskType taskType;
  final String description;
  final File? image;
  final DateTime? dateTime;

  bool isUrgent;

  Task({
   required this.id,
   required this.title,
   this.taskType = TaskType.work,
   required this.description,
   required this.image,
   required this.dateTime,
   this.isUrgent = false,
  });
}