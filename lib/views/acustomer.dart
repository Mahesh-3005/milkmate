import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.acustomer.dart';

class ACustomer extends StatelessWidget {
  final controller = Get.put(ACustomerController());
  ACustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        await Get.delete<ACustomerController>(
          force: true,
        ); // ✅ This WILL be triggered on swipe
        return true; // Allow back navigation
      },
      child:
    Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Center(
            child: Column(
              children: [
                Text(
                  'All Customers',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                      height: 1.h,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                SizedBox(height: 10.h),
                 Expanded(
                    child: ListView.builder(
                      itemCount: controller.customerList.length,
                      itemBuilder: (context, index) {
                        var customer = controller.customerList[index];
                        return 
                        Column(
                          children: [
                            Card(
                              // color: Colors.grey[100],
                              child: InkWell(
                                onTap:
                                    () => Get.toNamed(
                                      '/dcustomer',
                                      arguments: {'id': customer.id},
                                    ),
                                child: ListTile(
                                  dense: true,
                                  title: Text(
                                    "${customer.firstName} ${customer.middleName} ${customer.lastName}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}


// Column(
//                           children: [
//                             Card(
//                               color: Colors.grey.shade300,
//                               child: InkWell(
//                                 onTap:
//                                     () => Get.toNamed(
//                                       '/dcustomer',
//                                       arguments: {'id': customer.id},
//                                     ),
//                                 child: ListTile(
//                                   dense: true,
//                                   title: Text(
//                                     "${customer.firstName} ${customer.middleName} ${customer.lastName}",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.blueGrey.shade600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 3.h),
//                           ],
//                         );