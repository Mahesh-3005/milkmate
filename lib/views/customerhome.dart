import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:milklog/getx/controller/ct.customerhome.dart';
import 'package:milklog/getx/controller/ct.abill.dart';
import 'package:milklog/views/xadmindetail.dart';

// class CustomerHome extends StatelessWidget {
//   final CustomerHomeController controller = Get.put(CustomerHomeController());
//   CustomerHome({super.key});

//   @override
//   Widget build(BuildContext context) {


// Future<void> _showBillSelector() async {
//   String selected = 'daily';

//   // 1) PERIOD SELECTOR (full width bottom sheet)
//   await Get.bottomSheet(
//     StatefulBuilder(
//       builder: (c, setState) {
//         return Container(
//           width: Get.width,
//           constraints: BoxConstraints(maxWidth: Get.width),
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Select Period',
//                   style:
//                       TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//               RadioListTile<String>(
//                 title: Text('Daily'),
//                 value: 'daily',
//                 groupValue: selected,
//                 onChanged: (v) => setState(() => selected = v!),
//               ),
//               RadioListTile<String>(
//                 title: Text('Weekly'),
//                 value: 'weekly',
//                 groupValue: selected,
//                 onChanged: (v) => setState(() => selected = v!),
//               ),
//               RadioListTile<String>(
//                 title: Text('Monthly'),
//                 value: 'monthly',
//                 groupValue: selected,
//                 onChanged: (v) => setState(() => selected = v!),
//               ),
//               RadioListTile<String>(
//                 title: Text('Yearly'),
//                 value: 'yearly',
//                 groupValue: selected,
//                 onChanged: (v) => setState(() => selected = v!),
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Get.back(result: selected),
//                       child: Text("Next"),
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(result: null),
//                       child: Text("Cancel"),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     ),
//     isScrollControlled: true,
//   ).then((selectedPeriod) async {
//     if (selectedPeriod == null) return;

//     final context = Get.context!;
//     final now = DateTime.now();

//     // 2) DATE PICKER
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked == null) return;

//     DateTime start;
//     DateTime end;

//     if (selectedPeriod == 'daily') {
//       start = DateTime(picked.year, picked.month, picked.day);
//       end = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
//     } else if (selectedPeriod == 'weekly') {
//       start = picked.subtract(Duration(days: picked.weekday - 1));
//       end = start.add(Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
//     } else if (selectedPeriod == 'monthly') {
//       start = DateTime(picked.year, picked.month, 1);
//       end = DateTime(picked.year, picked.month + 1, 1)
//           .subtract(Duration(seconds: 1));
//     } else {
//       start = DateTime(picked.year, 1, 1);
//       end = DateTime(picked.year + 1, 1, 1).subtract(Duration(seconds: 1));
//     }

//     // 3) ACTION SELECTOR (full width bottom sheet)
//     await Get.bottomSheet(
//       Container(
//         width: Get.width,
//         constraints: BoxConstraints(maxWidth: Get.width),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Choose Action",
//                 style: TextStyle(
//                     fontSize: 16.sp, fontWeight: FontWeight.bold)),
//             SizedBox(height: 12.h),

//             ElevatedButton.icon(
//               icon: Icon(Icons.print),
//               label: Text("Print"),
//               onPressed: () => Get.back(result: "print"),
//             ),
//             SizedBox(height: 8.h),

//             ElevatedButton.icon(
//               icon: Icon(Icons.share),
//               label: Text("Share"),
//               onPressed: () => Get.back(result: "share"),
//             ),
//             SizedBox(height: 8.h),

//             ElevatedButton.icon(
//               icon: Icon(Icons.print_outlined),
//               label: Text("Print & Share"),
//               onPressed: () => Get.back(result: "both"),
//             ),
//             SizedBox(height: 8.h),

//             OutlinedButton(
//               onPressed: () => Get.back(result: null),
//               child: Text("Cancel"),
//             ),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//     ).then((action) async {
//       if (action == null) return;

//       final abill = Get.put(ABillController());

//       // PROGRESS DIALOG
//       Get.dialog(
//         Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(width: 12),
//                 Text("Preparing document..."),
//               ],
//             ),
//           ),
//         ),
//         barrierDismissible: false,
//       );

//       try {
//         final bytes = await abill.buildPdfBytes(start, end);

//         Get.back(); // close progress

//         if (action == "print" || action == "both") {
//           await Printing.layoutPdf(onLayout: (format) async => bytes);
//         }

//         if (action == "share" || action == "both") {
//           final directory = Directory('/storage/emulated/0/Download');
//           if (!await directory.exists()) directory.create(recursive: true);

//           final path =
//               '${directory.path}/MilkDelivered_${start.day}-${start.month}-${start.year}_to_${end.day}-${end.month}-${end.year}.pdf';

//           final file = File(path);
//           await file.writeAsBytes(bytes);

//           await Share.shareXFiles(
//             [XFile(path)],
//             text:
//                 "📄 Milk Delivery Report (${start.day}-${start.month}-${start.year} → ${end.day}-${end.month}-${end.year})",
//           );
//         }
//       } catch (e) {
//         Get.back();
//         Get.snackbar("Error", e.toString());
//       }
//     });
//   });
// }


//     return WillPopScope(
//       onWillPop: () async {
//         // final prefs = await SharedPreferences.getInstance();
//         // await prefs.clear();
//         return false; // Allow back navigation
//       },
//       child:
//     Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     height: 0.2.h,
//                     color: Colors.blueGrey.shade900,
//                   ),
//                 ),
//                 Obx(()=>
//                    Text(
//                     controller.name.value,
//                         style: TextStyle(
//                           fontSize: 25.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                 ),
//                 Container(
//                       height: 1.h,
//                       decoration: BoxDecoration(color: Colors.grey),
//                     ),
//                 SizedBox(height: 20.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () => Get.toNamed('/deliverystatus'),
//                       child: Container(
//                         height: 70.h,
//                         width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.sp),
//                           color: Colors.deepPurple[300],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Delivery \nStatus',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => Get.toNamed('/dcustomer',arguments: {'role':'Customer'}),
//                       child: Container(
//                         height: 70.h,
//                         width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.sp),
//                           color: Colors.deepPurple[300],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'My Profile',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                                 SizedBox(height: 20.h),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () => Get.to(() => XAdminDetail()),
//                       // onTap: () => Get.toNamed('/deliverystatus'),
//                       child: Container(
//                         height: 70.h,
//                         width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.sp),
//                           color: Colors.deepPurple[300],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Admin \nDetails',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => _showBillSelector(),
//                       child: Container(
//                         height: 70.h,
//                         width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.sp),
//                           color: Colors.deepPurple[300],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Get Bill',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30.h),
//                 Center(
//                   child: InkWell(
//                     onTap: () async {
//                       await controller.logout();
//                     },
//                     child: Container(
//                       height: 35.h,
//                       width: 110.w,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'logout',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }

class MilkLogColors {
  static const primary = Color(0xFF1E88E5);
  static const accent = Color(0xFF64B5F6);
  static const creamBg = Color(0xFFF5F7FA);
  static const darkBg = Color(0xFF0E1A24);
}

class _QuickTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickTile(this.label, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: MilkLogColors.primary),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}




class CustomerHome extends StatelessWidget {
  final CustomerHomeController controller = Get.put(CustomerHomeController());

  CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? MilkLogColors.darkBg : MilkLogColors.creamBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───────── Header ─────────
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.name.value,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )),

              const SizedBox(height: 28),

              /// ───────── Main Actions ─────────
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.4,
                children: [
                  _QuickTile(
                    "Delivery Status",
                    Icons.local_shipping,
                    () => Get.toNamed('/deliverystatus'),
                  ),
                  _QuickTile(
                    "My Profile",
                    Icons.person,
                    () => Get.toNamed('/dcustomer',
                        arguments: {'role': 'Customer'}),
                  ),
                  _QuickTile(
                    "Admin Details",
                    Icons.admin_panel_settings,
                    () => Get.to(() => XAdminDetail()),
                  ),
                  _QuickTile(
                    "Get Bill",
                    Icons.receipt_long,
                    () => _showBillSelector(),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              /// ───────── Logout Button ─────────
              Center(
                child: SizedBox(
                  width: 180,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await controller.logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MilkLogColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
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
  /// ───────── BILL SELECTOR (unchanged logic, just UI improved) ─────────
//   Future<void> _showBillSelector() async {
//     String selected = 'daily';

//     await Get.bottomSheet(
//       StatefulBuilder(
//         builder: (c, setState) {
//           return Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Get.theme.cardColor,
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(24)),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Select Period",
//                   style:
//                       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 10),

//                 ...['daily', 'weekly', 'monthly', 'yearly']
//                     .map(
//                       (e) => RadioListTile<String>(
//                         title: Text(e.capitalizeFirst!),
//                         value: e,
//                         groupValue: selected,
//                         onChanged: (v) =>
//                             setState(() => selected = v!),
//                       ),
//                     )
//                     .toList(),

//                 const SizedBox(height: 10),

//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => Get.back(result: selected),
//                         child: const Text("Next"),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Get.back(),
//                         child: const Text("Cancel"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       isScrollControlled: true,
//     ).then((selectedPeriod) async {
//       if (selectedPeriod == null) return;

//       final picked = await showDatePicker(
//         context: Get.context!,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2100),
//       );

//       if (picked == null) return;

//       DateTime start;
//       DateTime end;

//       if (selectedPeriod == 'daily') {
//         start = DateTime(picked.year, picked.month, picked.day);
//         end = DateTime(picked.year, picked.month, picked.day, 23, 59);
//       } else if (selectedPeriod == 'weekly') {
//         start = picked.subtract(Duration(days: picked.weekday - 1));
//         end = start.add(const Duration(days: 6));
//       } else if (selectedPeriod == 'monthly') {
//         start = DateTime(picked.year, picked.month, 1);
//         end = DateTime(picked.year, picked.month + 1, 1)
//             .subtract(const Duration(seconds: 1));
//       } else {
//         start = DateTime(picked.year, 1, 1);
//         end = DateTime(picked.year + 1, 1, 1)
//             .subtract(const Duration(seconds: 1));
//       }

//       final action = await Get.bottomSheet(
//         Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Get.theme.cardColor,
//             borderRadius:
//                 const BorderRadius.vertical(top: Radius.circular(24)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Action",
//                   style: TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.w600)),
//               const SizedBox(height: 12),

//               ElevatedButton.icon(
//                 icon: const Icon(Icons.print),
//                 label: const Text("Print"),
//                 onPressed: () => Get.back(result: "print"),
//               ),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.share),
//                 label: const Text("Share"),
//                 onPressed: () => Get.back(result: "share"),
//               ),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.print_outlined),
//                 label: const Text("Print & Share"),
//                 onPressed: () => Get.back(result: "both"),
//               ),
//             ],
//           ),
//         ),
//       );

//       if (action == null) return;

//       final abill = Get.put(ABillController());

//       Get.dialog(
//         const Center(child: CircularProgressIndicator()),
//         barrierDismissible: false,
//       );

//       try {
//         final bytes = await abill.buildPdfBytes(start, end);
//         Get.back();

//         if (action == "print" || action == "both") {
//           await Printing.layoutPdf(onLayout: (_) async => bytes);
//         }

//         if (action == "share" || action == "both") {
//           final path = '/storage/emulated/0/Download/bill.pdf';
//           final file = File(path);
//           await file.writeAsBytes(bytes);

//           await Share.shareXFiles([XFile(path)]);
//         }
//       } catch (e) {
//         Get.back();
//         Get.snackbar("Error", e.toString());
//       }
//     });
//   }
// }

Future<void> _showBillSelector() async {
  String selected = 'daily';

  /// 🔹 1. PERIOD SELECTOR (Modern)
  final selectedPeriod = await Get.bottomSheet<String>(
    StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              const Text(
                "Select Period",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              /// Options (Modern tiles)
              ...['daily', 'weekly', 'monthly', 'yearly'].map((e) {
                final isSelected = selected == e;

                return InkWell(
                  onTap: () => setState(() => selected = e),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? MilkLogColors.primary.withOpacity(0.1)
                          : null,
                      border: Border.all(
                        color: isSelected
                            ? MilkLogColors.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected
                              ? MilkLogColors.primary
                              : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e.capitalizeFirst!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 10),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: selected),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MilkLogColors.primary,
                      ),
                      child: const Text("Next"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );

  if (selectedPeriod == null) return;

  /// 🔹 2. DATE PICKER (keep same)
  // final picked = await showDatePicker(
  //   context: Get.context!,
  //   initialDate: DateTime.now(),
  //   firstDate: DateTime(2000),
  //   lastDate: DateTime(2100),
  // );

  final picked = await showDatePicker(
  context: Get.context!,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),

  builder: (context, child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: MilkLogColors.primary,       // header + selected date
          onPrimary: Colors.white,              // text on header
          onSurface: Colors.black87,            // normal text
        ),
        dialogBackgroundColor: Theme.of(context).cardColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: MilkLogColors.primary,
          ),
        ),
      ),
      child: child!,
    );
  },
);

  if (picked == null) return;

  DateTime start;
  DateTime end;

  if (selectedPeriod == 'daily') {
    start = DateTime(picked.year, picked.month, picked.day);
    end = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
  } else if (selectedPeriod == 'weekly') {
    start = picked.subtract(Duration(days: picked.weekday - 1));
    end = start.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
  } else if (selectedPeriod == 'monthly') {
    start = DateTime(picked.year, picked.month, 1);
    end = DateTime(picked.year, picked.month + 1, 1)
        .subtract(const Duration(seconds: 1));
  } else {
    start = DateTime(picked.year, 1, 1);
    end = DateTime(picked.year + 1, 1, 1)
        .subtract(const Duration(seconds: 1));
  }

  /// 🔹 3. ACTION SELECTOR (Modern)
  final action = await Get.bottomSheet<String>(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).cardColor,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose Action",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          _actionTile("Print", Icons.print, "print"),
          _actionTile("Share", Icons.share, "share"),
          _actionTile("Print & Share", Icons.picture_as_pdf, "both"),

          const SizedBox(height: 10),

          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );

  if (action == null) return;

  final abill = Get.put(ABillController());

  /// 🔹 4. MODERN LOADING DIALOG
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Generating bill..."),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  try {
    final bytes = await abill.buildPdfBytes(start, end);

    Get.back(); // close loader

    if (action == "print" || action == "both") {
      await Printing.layoutPdf(onLayout: (format) async => bytes);
    }

    if (action == "share" || action == "both") {
      final dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) dir.create(recursive: true);

      final file = File(
          '${dir.path}/Milk_${start.day}-${start.month}_to_${end.day}-${end.month}.pdf');

      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)]);
    }
  } catch (e) {
    Get.back();
    Get.snackbar("Error", e.toString());
  }
}

Widget _actionTile(String title, IconData icon, String value) {
  return InkWell(
    onTap: () => Get.back(result: value),
    borderRadius: BorderRadius.circular(16),
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: MilkLogColors.primary),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    ),
  );
}