import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPickerInput extends StatefulWidget {
  const DataPickerInput({Key? key}) : super(key: key);

  @override
  State<DataPickerInput> createState() => _DataPickerInputState();
}

class _DataPickerInputState extends State<DataPickerInput> {
  DateTime currentDate = DateTime(2017);
  bool showTime = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        locale: const Locale('uk'),
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        showTime = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 34),
        color: const Color(0xFFFBEFB4),
        child: (showTime)
            ? ListTile(
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),

                onTap: () => _selectDate(context),
                title:
                    Text(DateFormat.yMMMMd('uk').format(currentDate)), // yMMMMd
              )
            : ListTile(
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                onTap: () => _selectDate(context),
                title: Text('Дата завершення:')));
  }
}
