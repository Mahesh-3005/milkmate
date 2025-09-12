import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.customerhome.dart';

class CustomerHome extends StatelessWidget {
  final CustomerHomeController controller = Get.put(CustomerHomeController());
  CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {
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
