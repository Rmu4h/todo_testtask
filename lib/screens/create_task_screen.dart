
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
  final _titleController = TextEditingController();
  bool isUrgent = false;
  final _formKey = GlobalKey<FormState>();
  final _newTask = Task(id: null, title: '', description: '', image: null, dateTime: null);
  bool _isLoading = false;


  Future<void> _saveFrom() async{
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try{
      await Provider.of<Tasks>(context, listen: false).addTask(_newTask);
    }catch(error){
      print('save form error');
      await showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text('An error occurred'),
        content: const Text('Something went wrong'),
        actions: [
          TextButton(onPressed: (){

            Navigator.of(context).pop();

          }, child: const Text('Okay'))
        ],
      ));
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        // width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA9A9A9), Color(0xFF383838)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 70, 36, 23),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back, size: 24, color: Theme.of(context).colorScheme.primary,)),
                    // TextFormField()
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Назва завдання...',
                          border: InputBorder.none,
                            labelStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        controller: _titleController,
                      ),
                    ),
                  ],
                ),
              ),
              RadioInput(
                initialValue: TaskType.work,
                onChanged: (value) {
                  // Handle the selected value change here
                  print('Selected value: $value');
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),

                color: const Color(0xFFFBEFB4),
                child: TextFormField(
                  initialValue: 'Додати опис...',
                  maxLines: 3,
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
                        // taskType = TaskType.work;
                        // widget.onChanged(taskType!);
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
                            : Container(
                          // width: 23.0,
                          // height: 23.0,
                        ),
                      ),
                    ),
                  ),
                  title: Text('Термінове'),

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)
                ),
                onPressed: () {
                  // Navigator.of(context).pushNamed(TasksOverviewScreen.routeName);
                  // Navigator.of(context).pop();
                },
                child: Text(
                  'Створити',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      // height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
