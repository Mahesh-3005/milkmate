import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.registration.dart';
import 'package:milklog/others/components/textfield.dart';

class Registration extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());
  Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, top: 50.h, right: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w600,
                        height: 0.2.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 3.w),
                      child: Text(
                        'Organization',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          // color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                // ToggleSwitch(
                //   minWidth: 150.0,
                //   cornerRadius: 20.0,
                //   activeBgColors: [
                //     [Colors.blue],
                //     [Colors.blue],
                //   ],
                //   activeFgColor: Colors.white,
                //   inactiveBgColor: Colors.grey.shade400,
                //   inactiveFgColor: Colors.white,
                //   initialLabelIndex: 1,
                //   totalSwitches: 2,
                //   labels: ['Create Organization', 'Join Organization'],
                //   radiusStyle: true,
                //   fontSize: 14.sp,
                //   onToggle: (index) {
                //     print('switched to: $index');
                //     controller.toggleIndex.value = index!;
                //   },
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Column(
                    children: [
                      MyTextfield(
                        hinttext: 'First Name',
                        controller: controller.fnameCtrl,
                      ),
                      SizedBox(height: 10.h),
                      MyTextfield(
                        hinttext: 'Last Name',
                        controller: controller.lnameCtrl,
                      ),
                      SizedBox(height: 10.h),
                      MyTextfield(
                        hinttext: 'Phone',
                        controller: controller.phoneCtrl,
                        maxlength: 10,
                        type: TextInputType.number,
                      ),
                      SizedBox(height: 10.h),
                      MyTextfield(
                        hinttext: 'Create Password',
                        controller: controller.passwordCtrl,
                      ),
                      SizedBox(height: 10.h),
                      MyTextfield(
                        hinttext: 'Organization name',
                        controller: controller.organizationCtrl,
                      ),
                      SizedBox(height: 10.h),
                      MyTextfield(
                        hinttext: 'Set Organization Key',
                        controller: controller.keyCtrl,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Center(
                  child: InkWell(
                    onTap: () async {
                      await controller.performOperation(
                        // controller.toggleIndex.value,
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.sp),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      InkWell(
                        onTap: () => Get.offAllNamed('/login'),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
