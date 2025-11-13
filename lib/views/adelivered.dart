import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.adelivered.dart';

class ADelivered extends StatelessWidget {
  final controller = Get.put(ADeliveredController());
  ADelivered({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.delete<ADeliveredController>(
          force: true,
        ); // ✅ This WILL be triggered on swipe
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Mark Customers',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                          controller.selectedDate.value
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  controller
                                      .selectedDate
                                      .value, // default to today
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2030),
                            );

                            if (picked != null) {
                              controller.setDate(picked);
                            }
                          },
                          icon: Icon(Icons.calendar_month_sharp),
                        ),
                          ],
                        ),
                        // TextButton(onPressed: () => controller.isTodayMarked(), child: Text(
                        //     'Check',
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),)
                      ],
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: controller.clearAll,
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.selectAll,
                        child: const Text(
                          'Select All',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: controller.customerList.length,
                        itemBuilder: (context, index) {
                          final customer = controller.customerList[index];

                          return Obx(() {
                            final isSel = controller.isSelected(index);

                            return Card(
                              child: ListTile(
                                dense: true,
                                title: Text(
                                  '${index + 1}. ${customer.firstName} ${customer.lastName}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onTap:
                                    () => controller.toggle(
                                      index,
                                      customer.id,
                                    ), // tap whole tile
                                trailing: Container(
                                  width: 22.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          isSel
                                              ? Colors.purple.shade300
                                              : Colors.grey,
                                      width: 2,
                                    ),
                                    color:
                                        isSel
                                            ? Colors.purple.shade300
                                                .withOpacity(0.2)
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:
                                      isSel
                                          ? const Icon(
                                            Icons.check,
                                            size: 18,
                                            color: Colors.purple,
                                          )
                                          : const SizedBox.shrink(),
                                ),
                              ),
                            );
                          });
                        },
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            controller.saveCustomer();
                            Get.offAllNamed('/home');
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
                                'Save',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
