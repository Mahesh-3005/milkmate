import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.abill.dart';

class ABill extends StatelessWidget {
  final controller = Get.put(ABillController());
  ABill({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.delete<ABillController>(
          force: true,
        ); // ✅ This WILL be triggered on swipe
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Generate Bill',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date :',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextField(
                        controller: controller.startDateController,
                        readOnly: true, // Prevents keyboard from appearing
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true, // Optional: adds background
                          fillColor:
                              Colors
                                  .grey
                                  .shade200, // Optional: background color
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                        ),
                        onTap: () => controller.selectStartDate(context),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'End Date :',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextField(
                        controller: controller.endDateController,
                        readOnly: true, // Prevents keyboard from appearing
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true, // Optional: adds background
                          fillColor:
                              Colors
                                  .grey
                                  .shade200, // Optional: background color
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                        ),
                        onTap: () => controller.selectEndDate(context),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (controller.startDate.value !=
                                        DateTime(2000, 1, 1) &&
                                    controller.endDate.value !=
                                        DateTime(2000, 1, 1)) {
                                  await controller.generateMatrixReport(
                                    controller.startDate.value,
                                    controller.endDate.value,
                                  );
                                } else {
                                  Get.snackbar(
                                    'Select Date',
                                    'Select start and end date',
                                  );
                                }
                              },
                              child: Text('Generate Excel'),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (controller.startDate.value !=
                                        DateTime(2000, 1, 1) &&
                                    controller.endDate.value !=
                                        DateTime(2000, 1, 1)) {
                                  await controller.generatePdfReport(
                                    controller.startDate.value,
                                    controller.endDate.value,
                                  );
                                } else {
                                  Get.snackbar(
                                    'Select Date',
                                    'Select start and end date',
                                  );
                                }
                              },
                              child: Text('Generate PDF'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await controller.exportDecoratedDeliveriesExcel(
                                controller.startDate.value,
                                controller.endDate.value,
                              );
                            },
                            child: Text('Extra Milk Excel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await controller.exportDeliveriesPDF(
                                controller.startDate.value,
                                controller.endDate.value,
                              );
                            },
                            child: Text('Extra Milk PDF'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
