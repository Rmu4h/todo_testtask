import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        if (widget.onChanged != null) {
          widget.onChanged(_value);
        }
      },
      child: Container(
        width: 33.0,
        height: 33.0,
        decoration: BoxDecoration(
          color: _value ? const Color(0xFFFBEFB4) : const Color(0xFFDBDBDB),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color(0xFF383838),
            width: 1.0,
          ),
        ),
        child: _value
            ? Icon(
          Icons.check,
          size: 20.0,
          color: Theme.of(context).colorScheme.secondary,
        )
            : null,
      ),
    );
  }
}