import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.login.dart';
import 'package:milklog/others/components/textfield.dart';

class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, top: 70.h, right: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 3.w),
                      child: Text(
                        'Login to continue',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Column(
                    children: [
                      MyTextfield(
                        maxlength: 10,
                        type: TextInputType.number,
                        hinttext: 'Phone',
                        controller: controller.phoneCtrl,
                      ),
                      SizedBox(height: 10.h),
                      MyTextfield(
                        hinttext: 'Password',
                        controller: controller.passwordCtrl,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                // Padding(
                //   padding: EdgeInsets.only(left: 5.w),
                //   child: Text('forgot Password?',style: TextStyle(fontSize: 14.sp,color: Colors.grey[600],fontWeight: FontWeight.w500),),
                // ),
                SizedBox(height: 25.h),
                Center(
                  child: InkWell(
                    onTap: () async{
                      await controller.login();
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
                          'Login',
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
                        'Create new account?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      InkWell(
                        onTap: () => Get.toNamed('/register'),
                        child: Text(
                          'Register',
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
