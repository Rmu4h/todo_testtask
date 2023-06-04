import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPickerInput extends StatefulWidget {
  final DateTime initialDateTime;
  final void Function(DateTime) onChanged;

  const DataPickerInput({
    Key? key,
    required this.initialDateTime,
    required this.onChanged,
  }) : super(key: key);

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

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        widget.onChanged(pickedDate);
        // widget.initialDateTime = pickedDate;
        currentDate = pickedDate;
        showTime = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 34),
        color: const Color(0xFFFBEFB4),
        child: (showTime)
            ? ListTile(
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),

                onTap: () => _selectDate(context),
                title: Text(
                  DateFormat.yMMMMd('uk').format(currentDate),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ), // yMMMMd
              )
            : ListTile(
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                onTap: () => _selectDate(context),
                title: Text(
                  'Дата завершення:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )));
  }
}
