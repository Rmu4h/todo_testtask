import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';
import '../widgets/datapicker_input.dart';
import '../widgets/image_input.dart';
import '../widgets/radio_input.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/edit-task';


  const EditTaskScreen( {Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TaskType selectedTaskType = TaskType.work;


  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    final taskValues = ModalRoute.of(context)!.settings.arguments as Task;
    final titleController = TextEditingController(text: taskValues.title);
    TextEditingController descriptionController = TextEditingController(text: taskValues.description);

    // final task = Provider.of<Task>(context, listen: false);

     print('taskValues ${taskValues.id}');
    print('taskValues title ${taskValues}');

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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
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
                        onSaved: (value) {
                          // newTask = Task(id: newTask.id,
                          //     title: value ?? '',
                          //     taskType: TaskType.work,
                          //     description: newTask.description,
                          //     image: newTask.image,
                          //     dateTime: newTask.dateTime,
                          //     isUrgent: newTask.isUrgent,
                          // );

                        },
                        // controller: _titleController,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.done,
                          size: 24,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                        )),
                  ],
                ),
              ),
              RadioInput(
                initialValue: taskValues.taskType,
                onChanged: (value) {
                  // Handle the selected value change here
                  // newTask = Task(id: newTask.id,
                  //     title: newTask.title,
                  //     taskType: value,
                  //     description: newTask.description,
                  //     image: newTask.image,
                  //     dateTime: newTask.dateTime,
                  //     isUrgent: newTask.isUrgent,
                  //
                  // );
                  selectedTaskType = value;
                  print('Selected value: $value');
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
                  // initialValue: taskValues.description,
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
                  onSaved: (value) {
                    // newTask = Task(id: newTask.id,
                    //     title: newTask.title,
                    //     taskType: newTask.taskType,
                    //     description: value ?? '',
                    //
                    //     image: newTask.image,
                    //     dateTime: newTask.dateTime);

                    print('onSaved _newTask ${taskValues}');

                  },
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
                  contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0),
                  leading: InkWell(
                    onTap: () {
                      setState(() {
                        // taskType = TaskType.work;
                        // widget.onChanged(taskType!);
                        taskValues.isUrgent = !taskValues.isUrgent;
                        // newTask = Task(id: newTask.id,
                        //   title: newTask.title,
                        //   taskType: newTask.taskType,
                        //   description: newTask.description,
                        //   image: newTask.image,
                        //   dateTime: newTask.dateTime,
                        //   isUrgent: isUrgent,
                        // );

                        print('this is isUrgent value ${taskValues.isUrgent}');
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
                          // width: 23.0,
                          // height: 23.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFD600),
                          ),
                        )
                            : Container(
                          // width: 23.0,
                          // height: 23.0,
                        ),
                      ),
                    ),
                  ),
                  title: Text('Термінове',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      // height: 1.2,
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
                    // _saveForm();
                    print('form saved');

                    print('this is title newTask ${taskValues.title}');
                    print('this is isUrgent newTask ${taskValues.isUrgent}');
                    print('this is dateTime newTask ${taskValues.dateTime}');

                    // Navigator.of(context).pushNamed(TasksOverviewScreen.routeName);
                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    'Створити',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondary,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      // height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        // child: Center(child: Column(
        //   children: [
        //     Text('${taskValues.id}'),
        //     Text('${taskValues.title}'),
        //     Text('${taskValues.taskType}'),
        //
        //     Text('${taskValues.description}'),
        //     Text('${taskValues.image}'),
        //     Text('${taskValues.dateTime}'),
        //     Text('${taskValues.isUrgent}'),
        //
        //
        //   ],
        // )),
      ),
    );
  }
}
