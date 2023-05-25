import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';
import '../providers/tasks.dart';
import '../widgets/datapicker_input.dart';
import '../widgets/image_input.dart';
import '../widgets/radio_input.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-task';

  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TaskType selectedTaskType = TaskType.work;

  final _formKey = GlobalKey<FormState>();
  late Task taskValues;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    taskValues = ModalRoute.of(context)!.settings.arguments as Task;

    super.didChangeDependencies();
  }

  Future<void> _saveUpdatedForm(
      id, title, taskType, description, dateTime, isUrgent, isCompleted) async {
    final editedTask = Task(
      id: id,
      title: title,
      taskType: taskType,
      description: description,
      dateTime: dateTime,
      isUrgent: isUrgent,
      isCompleted: isCompleted,
    );
    await Provider.of<Tasks>(context, listen: false).updateTask(id, editedTask);
  }

  Future<void> _deleteTask(id) async {
    await Provider.of<Tasks>(context, listen: false).deleteTask(id);
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: taskValues.title);
    TextEditingController descriptionController =
        TextEditingController(text: taskValues.description);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Form(
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
                    // TextFormField()
                    Expanded(
                      child: TextFormField(
                        // initialValue: taskValues.title,
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
                    IconButton(
                        onPressed: () {
                          _saveUpdatedForm(
                              taskValues.id,
                              titleController.text,
                              taskValues.taskType,
                              descriptionController.text,
                              taskValues.dateTime,
                              taskValues.isUrgent,
                              taskValues.isCompleted);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.done,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                ),
              ),
              RadioInput(
                initialValue: taskValues.taskType,
                onChanged: (value) {
                  selectedTaskType = value;
                },
                newTask: taskValues,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                color: const Color(0xFFFBEFB4),
                child: TextFormField(
                  controller: descriptionController,
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
              const DataPickerInput(),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
                color: const Color(0xFFFBEFB4),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  leading: InkWell(
                    onTap: () {
                      setState(() {
                        taskValues.isUrgent = !taskValues.isUrgent;
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
                        child: taskValues.isUrgent
                            ? Container(
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
                      backgroundColor: const Color(0xFFFF8989),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                  onPressed: () {
                    _deleteTask(taskValues.id);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Видалити',
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
