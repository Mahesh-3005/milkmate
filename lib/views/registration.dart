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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              /// Header (same style as login)
              Text(
                'Create account 👋',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 6.h),
              Text(
                'Set up your organization',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),

              SizedBox(height: 30.h),

              /// Card (same as login)
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:
                      isDark
                          ? []
                          : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                ),
                child: Column(
                  children: [
                    MyTextfield(
                      hinttext: 'First name',
                      controller: controller.fnameCtrl,
                    ),
                    SizedBox(height: 14.h),
                    MyTextfield(
                      hinttext: 'Last name',
                      controller: controller.lnameCtrl,
                    ),
                    SizedBox(height: 14.h),
                    MyTextfield(
                      hinttext: 'Phone number',
                      controller: controller.phoneCtrl,
                      maxlength: 10,
                      type: TextInputType.phone,
                    ),
                    SizedBox(height: 14.h),
                    MyTextfield(
                      hinttext: 'Create password',
                      controller: controller.passwordCtrl,
                      obscureText: true,
                    ),
                    SizedBox(height: 14.h),
                    MyTextfield(
                      hinttext: 'Organization name',
                      controller: controller.organizationCtrl,
                    ),
                    SizedBox(height: 14.h),
                    MyTextfield(
                      hinttext: 'Organization key',
                      controller: controller.keyCtrl,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              /// Create button (same as login)
              Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 54.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          controller.isLoading.value
                              ? [Colors.blueGrey, Colors.blueGrey]
                              : [Colors.blue, Colors.lightBlueAccent],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow:
                        controller.isLoading.value
                            ? []
                            : [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                  ),
                  child: ElevatedButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () => controller.performOperation(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child:
                        controller.isLoading.value
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Creating account...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                            : Text(
                              'Create account',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// Login redirect
              Center(
                child: InkWell(
                  onTap: () => Get.offAllNamed('/login'),
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}