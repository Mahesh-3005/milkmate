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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),

                /// Branding
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.lightBlueAccent],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.local_drink,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'MilkMate',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                /// Header
                Text(
                  'Welcome back 👋',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Login to continue',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),

                SizedBox(height: 30.h),

                /// Card
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextfield(
                        maxlength: 10,
                        type: TextInputType.phone,
                        hinttext: 'Phone number',
                        controller: controller.phoneCtrl,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),

                      /// Password with toggle
                      Obx(
                        () => MyTextfield(
                          hinttext: 'Password',
                          controller: controller.passwordCtrl,
                          obscureText: !controller.isPasswordVisible.value,
                          suffixicon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                () => controller.isPasswordVisible.toggle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: double.infinity,
                    height: 54.h,
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
                              : () => controller.login(),
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
                                  SizedBox(width: 14),
                                  Text(
                                    'Signing in...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                              : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                /// Register
                Center(
                  child: InkWell(
                    onTap: () => Get.toNamed('/register'),
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
