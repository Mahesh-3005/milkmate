// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class MyListTile extends StatelessWidget {
//   RxBool selected = false.obs;
//   final String name;
//   final Function? onTap;
//   MyListTile({super.key, required this.name,this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(
//           ()=> Card(
//             color: selected.value ? Colors.blue[300]:Colors.grey[100],
//             child: ListTile(
//               dense: true,
//               title: Text(
//                 name,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.blueGrey.shade600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               onTap: () {
//                 selected.value = !selected.value;
//                 onTap!(selected);
//               },
//             ),
//           ),
//         ),
//         SizedBox(height: 3.h),
//       ],
//     );
//   }
// }
