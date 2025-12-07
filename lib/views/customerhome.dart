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

class CustomerHome extends StatelessWidget {
  final CustomerHomeController controller = Get.put(CustomerHomeController());
  CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {


Future<void> _showBillSelector() async {
  String selected = 'daily';

  // 1) PERIOD SELECTOR (full width bottom sheet)
  await Get.bottomSheet(
    StatefulBuilder(
      builder: (c, setState) {
        return Container(
          width: Get.width,
          constraints: BoxConstraints(maxWidth: Get.width),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Period',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              RadioListTile<String>(
                title: Text('Daily'),
                value: 'daily',
                groupValue: selected,
                onChanged: (v) => setState(() => selected = v!),
              ),
              RadioListTile<String>(
                title: Text('Weekly'),
                value: 'weekly',
                groupValue: selected,
                onChanged: (v) => setState(() => selected = v!),
              ),
              RadioListTile<String>(
                title: Text('Monthly'),
                value: 'monthly',
                groupValue: selected,
                onChanged: (v) => setState(() => selected = v!),
              ),
              RadioListTile<String>(
                title: Text('Yearly'),
                value: 'yearly',
                groupValue: selected,
                onChanged: (v) => setState(() => selected = v!),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: selected),
                      child: Text("Next"),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(result: null),
                      child: Text("Cancel"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  ).then((selectedPeriod) async {
    if (selectedPeriod == null) return;

    final context = Get.context!;
    final now = DateTime.now();

    // 2) DATE PICKER
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    DateTime start;
    DateTime end;

    if (selectedPeriod == 'daily') {
      start = DateTime(picked.year, picked.month, picked.day);
      end = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
    } else if (selectedPeriod == 'weekly') {
      start = picked.subtract(Duration(days: picked.weekday - 1));
      end = start.add(Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    } else if (selectedPeriod == 'monthly') {
      start = DateTime(picked.year, picked.month, 1);
      end = DateTime(picked.year, picked.month + 1, 1)
          .subtract(Duration(seconds: 1));
    } else {
      start = DateTime(picked.year, 1, 1);
      end = DateTime(picked.year + 1, 1, 1).subtract(Duration(seconds: 1));
    }

    // 3) ACTION SELECTOR (full width bottom sheet)
    await Get.bottomSheet(
      Container(
        width: Get.width,
        constraints: BoxConstraints(maxWidth: Get.width),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose Action",
                style: TextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),

            ElevatedButton.icon(
              icon: Icon(Icons.print),
              label: Text("Print"),
              onPressed: () => Get.back(result: "print"),
            ),
            SizedBox(height: 8.h),

            ElevatedButton.icon(
              icon: Icon(Icons.share),
              label: Text("Share"),
              onPressed: () => Get.back(result: "share"),
            ),
            SizedBox(height: 8.h),

            ElevatedButton.icon(
              icon: Icon(Icons.print_outlined),
              label: Text("Print & Share"),
              onPressed: () => Get.back(result: "both"),
            ),
            SizedBox(height: 8.h),

            OutlinedButton(
              onPressed: () => Get.back(result: null),
              child: Text("Cancel"),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    ).then((action) async {
      if (action == null) return;

      final abill = Get.put(ABillController());

      // PROGRESS DIALOG
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 12),
                Text("Preparing document..."),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      try {
        final bytes = await abill.buildPdfBytes(start, end);

        Get.back(); // close progress

        if (action == "print" || action == "both") {
          await Printing.layoutPdf(onLayout: (format) async => bytes);
        }

        if (action == "share" || action == "both") {
          final directory = Directory('/storage/emulated/0/Download');
          if (!await directory.exists()) directory.create(recursive: true);

          final path =
              '${directory.path}/MilkDelivered_${start.day}-${start.month}-${start.year}_to_${end.day}-${end.month}-${end.year}.pdf';

          final file = File(path);
          await file.writeAsBytes(bytes);

          await Share.shareXFiles(
            [XFile(path)],
            text:
                "📄 Milk Delivery Report (${start.day}-${start.month}-${start.year} → ${end.day}-${end.month}-${end.year})",
          );
        }
      } catch (e) {
        Get.back();
        Get.snackbar("Error", e.toString());
      }
    });
  });
}


    return WillPopScope(
      onWillPop: () async {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.clear();
        return false; // Allow back navigation
      },
      child:
    Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 0.2.h,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                Obx(()=>
                   Text(
                    controller.name.value,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Container(
                      height: 1.h,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed('/deliverystatus'),
                      child: Container(
                        height: 70.h,
                        width: (MediaQuery.sizeOf(context).width / 5) * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.deepPurple[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delivery \nStatus',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed('/dcustomer',arguments: {'role':'Customer'}),
                      child: Container(
                        height: 70.h,
                        width: (MediaQuery.sizeOf(context).width / 5) * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.deepPurple[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'My Profile',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.to(() => XAdminDetail()),
                      // onTap: () => Get.toNamed('/deliverystatus'),
                      child: Container(
                        height: 70.h,
                        width: (MediaQuery.sizeOf(context).width / 5) * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.deepPurple[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Admin \nDetails',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _showBillSelector(),
                      child: Container(
                        height: 70.h,
                        width: (MediaQuery.sizeOf(context).width / 5) * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.deepPurple[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Bill',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Center(
                  child: InkWell(
                    onTap: () async {
                      await controller.logout();
                    },
                    child: Container(
                      height: 35.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
