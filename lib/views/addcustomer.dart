import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.addcustomer.dart';
import 'package:milklog/others/components/textfield.dart';

class AddCustomer extends StatelessWidget {
  final controller = Get.put(AddCustomerController());
  AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h,bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Add Customer',
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
                    Text(
                      'First Name :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(hinttext: '', controller: controller.fnameCtrl),
                    SizedBox(height: 8.h),
                    Text(
                      'Middle Name :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.mnameCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Last Name :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.lnameCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Phone :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      type: TextInputType.number,
                      hinttext: '',
                      controller: controller.phoneCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Address :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.addressCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Quantity :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      type: TextInputType.number,
                      hinttext: 'Ex. 1/1.5',
                      controller: controller.quantityCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Rate :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      type: TextInputType.number,
                      hinttext: 'Ex. 75/80.5',
                      controller: controller.rateCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Milk Type :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: 'Ex. Cow/Buffalo',
                      controller: controller.milkTypeCtrl,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Delivery Time :',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: 'Ex. Morning/Evening',
                      controller: controller.deliveryTimeCtrl,
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          if (await controller.saveCustomer()) {
                            Get.offNamed('/home');
                          }
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
            ],
          ),
        ),
      ),
    );
  }
}