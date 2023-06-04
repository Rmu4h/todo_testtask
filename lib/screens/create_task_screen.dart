import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_testtask/providers/task.dart';

import '../providers/tasks.dart';
import '../widgets/datapicker_input.dart';
import '../widgets/image_input.dart';
import '../widgets/radio_input.dart';

class CreateTaskScreen extends StatefulWidget {
  static const routeName = '/create-task';

  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final titleController = TextEditingController();
  TaskType selectedTaskType = TaskType.work;
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  bool isUrgent = false;

  final _formKey = GlobalKey<FormState>();
  var newTask = Task(
      id: null,
      taskType: TaskType.work,
      title: '',
      description: '',
      image: null,
      dateTime: DateTime.now());
  bool _isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveForm(BuildContext context) async {
    final isValid = _formKey.currentState?.validate();
    String title = titleController.text;
    String description = descriptionController.text;

    if (!isValid!) {
      return;
    }

    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    newTask = Task(
      id: newTask.id,
      title: title,
      taskType: selectedTaskType,
      description: description,
      image: newTask.image,
      dateTime: selectedDate,
      isUrgent: isUrgent,
    );

    try {
      Provider.of<Tasks>(context, listen: false).addTask(newTask);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('An error occurred'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Okay'))
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });

    if (context.mounted) Navigator.of(context).pop();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(36, 70, 36, 23),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          Expanded(
                            child: TextFormField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                  labelText: 'Назва завдання...',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  )),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide a value';
                                }

                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    RadioInput(
                      initialValue: TaskType.work,
                      onChanged: (value) {
                        // Handle the selected value change here
                        selectedTaskType = value;
                      },
                      newTask: newTask,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                      color: const Color(0xFFFBEFB4),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Додати опис...',
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              // height: 21,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        controller: descriptionController,
                        // initialValue: 'Додати опис...',
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          if (value.length < 10) {
                            return 'Should be at least 10 characters long.';
                          }

                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const ImageInput(),
                    const SizedBox(
                      height: 16,
                    ),
                    DataPickerInput(
                        initialDateTime: selectedDate,
                        onChanged: (dateTimeValue) {
                          selectedDate = dateTimeValue;
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                      color: const Color(0xFFFBEFB4),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 0.0, right: 0.0),
                        leading: InkWell(
                          onTap: () {
                            setState(() {
                              isUrgent = !isUrgent;
                            });
                          },
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBDBDB),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFDBDBDB),
                                width: 7.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: isUrgent
                                  ? Container(
                                      // width: 23.0,
                                      // height: 23.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFFD600),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        title: Text(
                          'Термінове',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                        onPressed: () {
                          _saveForm(context);
                        },
                        child: Text(
                          'Створити',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
