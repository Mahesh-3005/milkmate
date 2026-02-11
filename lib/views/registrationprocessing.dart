import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.registrationprocessing.dart';

class RegistrationProcessingPage extends StatelessWidget {
  final controller = Get.put(RegistrationProcessingController());

  RegistrationProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Brand (same)
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.local_drink,
                  size: 42,
                  color: Color(0xFF1976D2),
                ),
              ),

              SizedBox(height: 40.h),

              /// Animation Area (same logic)
              Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child:
                      controller.isSuccess.value
                          ? _SuccessTick()
                          : controller.isFailure.value
                          ? const Icon(Icons.close, size: 70, color: Colors.red)
                          : _LoaderRing(),
                ),
              ),

              SizedBox(height: 32.h),

              /// Status Text (same)
              Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    controller.statusText.value,
                    key: ValueKey(controller.statusText.value),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
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

class _LoaderRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: const AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}

class _SuccessTick extends StatefulWidget {
  @override
  State<_SuccessTick> createState() => _SuccessTickState();
}

class _SuccessTickState extends State<_SuccessTick>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.green, size: 40),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
