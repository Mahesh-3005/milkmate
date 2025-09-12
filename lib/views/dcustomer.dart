import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.dcustomer.dart';

class DCustomer extends StatelessWidget {
  final controller = Get.put(DCustomerController());
  DCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Customer Details',
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
                      'Quantity',
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
                        '${controller.quantity.string} Liter/Day',
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
                      'Rate',
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
                        '₹ ${controller.rate.string}',
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
                      'Milk Type',
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
                        controller.milktype.value,
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
                      'Delivery Time',
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
                        controller.deliverytime.value,
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
              SizedBox(height: 20.h),
              !controller.isCustomer.value ?
              Center(
                child: Container(
                  height: 35.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap:
                          () => Get.offNamed(
                            '/dcustomerprofile',
                            arguments: {
                              "id":
                                  Get.arguments != null
                                      ? "${Get.arguments['id']}"
                                      : '',
                            },
                          ),
                      child: Text(
                        'Edit Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}
