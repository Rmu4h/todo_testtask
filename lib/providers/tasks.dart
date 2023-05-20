import 'package:flutter/material.dart';
import 'package:todo_testtask/providers/task.dart';

class Tasks with ChangeNotifier{
  List<Task> _items= [];

  Future<void> fetchTasks() async{}

  Future<void> addProduct() async{}

  Future<void> updateProduct() async{}

  Future<void> deleteProduct() async{}
}