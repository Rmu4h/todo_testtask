// import 'package:flutter/material.dart';
//
// class IsUrgent extends StatefulWidget {
//   const IsUrgent({Key? key}) : super(key: key);
//
//   @override
//   State<IsUrgent> createState() => _IsUrgentState();
// }
//
// class _IsUrgentState extends State<IsUrgent> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
//       color: const Color(0xFFFBEFB4),
//       child: ListTile(
//         contentPadding:
//         const EdgeInsets.only(left: 0.0, right: 0.0),
//         leading: InkWell(
//           onTap: () {
//             setState(() {
//               // taskType = TaskType.work;
//               // widget.onChanged(taskType!);
//               isUrgent = !isUrgent;
//             });
//           },
//           child: Container(
//             width: 30.0,
//             height: 30.0,
//             decoration: BoxDecoration(
//               color: const Color(0xFFDBDBDB),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: const Color(0xFFDBDBDB),
//                 width: 7.0,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: isUrgent
//                   ? Container(
//                 // width: 23.0,
//                 // height: 23.0,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFFFFD600),
//                 ),
//               )
//                   : Container(
//                 // width: 23.0,
//                 // height: 23.0,
//               ),
//             ),
//           ),
//         ),
//         title: Text('Термінове',
//           style: TextStyle(
//             color: Theme
//                 .of(context)
//                 .colorScheme
//                 .secondary,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             // height: 1.2,
//           ),
//         ),
//       ),
//     ),
//   }
// }
