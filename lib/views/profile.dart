import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.profile.dart';

class Profile extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                height: 1.h,
                decoration: BoxDecoration(color: Colors.grey),
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'First Name',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.firstname.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Middle Name',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.middlename.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Last Name',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.lastname.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.phone.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      flex: 1,
                      child: Text(
                        controller.address.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Organization \nName',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.organizationname.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Organization \nKey',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.organizationkey.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Center(
                child: InkWell(
                  onTap: () => Get.offNamed('/editprofile'),
                  child: Container(
                    height: 35.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
