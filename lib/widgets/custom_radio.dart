// import 'package:flutter/material.dart';
// import 'package:todo_testtask/widgets/radio_input.dart';
//
// enum SwitchValue { Value1, Value2 }
//
//
// class RadioLikeCheckbox extends StatefulWidget {
//   final SwitchValue initialValue;
//   final void Function(SwitchValue) onChanged;
//
//   const RadioLikeCheckbox({
//     super.key,
//     required this.initialValue,
//     required this.onChanged,
//   });
//
//   @override
//   _RadioLikeCheckboxState createState() => _RadioLikeCheckboxState();
// }
//
// class _RadioLikeCheckboxState extends State<RadioLikeCheckbox> {
//   SwitchValue? selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.initialValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedValue = SwitchValue.Value1;
//           widget.onChanged(selectedValue!);
//         });
//       },
//       child: Container(
//         width: 30.0,
//         height: 30.0,
//         decoration: BoxDecoration(
//           color: const Color(0xFFDBDBDB),
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: const Color(0xFFDBDBDB),
//             width: 7.0,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: isChecked
//               ? Container(
//             // width: 23.0,
//             // height: 23.0,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0xFFFFD600),
//             ),
//           )
//               : Container(
//             // width: 23.0,
//             // height: 23.0,
//           ),
//         ),
//       ),
//     );
//   }
// }