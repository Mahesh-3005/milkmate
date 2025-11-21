import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.dcustomerprofile.dart';
import 'package:milklog/others/components/textfield.dart';

class DCustomerProfile extends StatelessWidget {
  final DCustomerProfileController controller = Get.put(
    DCustomerProfileController(),
  );
  DCustomerProfile({super.key});

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
                        'Edit Details',
                        style: TextStyle(
                          fontSize: 30.sp,
                          // color: Colors.blueGrey.shade900,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      height: 1.h,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'First Name:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.fnameCtrl,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Middle Name:',
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
                    SizedBox(height: 10.h),
                    Text(
                      'Last Name:',
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
                   SizedBox(height: 10.h),
                    Text(
                      'Phone:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.phoneCtrl,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.addressCtrl
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Quantity:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.quantityCtrl,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Rate:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.rateCtrl,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Milk Type:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.milkTypeCtrl,
                    ),
                   SizedBox(height: 10.h),
                    Text(
                      'Delivery Time:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MyTextfield(
                      hinttext: '',
                      controller: controller.deliveryTimeCtrl,
                    ),
                    SizedBox(height: 10.h),
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
                            onTap: () async {
                              if (await controller.save()) {
                                Get.snackbar("Success", "Customer Details Updated Successfully");
                                Get.offNamed('/acustomer');
                              }
                            },
                            child: Text(
                              'Save',
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
            ],
          ),
        ),
      ),
    );
  }
}
