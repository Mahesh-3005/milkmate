import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.dcustomerprofile.dart';
import 'package:milklog/others/components/textfield.dart';

// class DCustomerProfile extends StatelessWidget {
//   final DCustomerProfileController controller = Get.put(
//     DCustomerProfileController(),
//   );
//   DCustomerProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h,bottom: 20.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         'Edit Details',
//                         style: TextStyle(
//                           fontSize: 30.sp,
//                           // color: Colors.blueGrey.shade900,
//                           fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 1.h,
//                       decoration: BoxDecoration(color: Colors.grey),
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'First Name:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.fnameCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Middle Name:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.mnameCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Last Name:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.lnameCtrl,
//                     ),
//                    SizedBox(height: 10.h),
//                     Text(
//                       'Phone:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.phoneCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Address:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.addressCtrl
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Quantity:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.quantityCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Rate:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.rateCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Milk Type:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.milkTypeCtrl,
//                     ),
//                    SizedBox(height: 10.h),
//                     Text(
//                       'Delivery Time:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.deliveryTimeCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Center(
//                       child: Container(
//                         height: 35.h,
//                         width: 110.w,
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Center(
//                           child: InkWell(
//                             onTap: () async {
//                               if (await controller.save()) {
//                                 Get.snackbar("Success", "Customer Details Updated Successfully");
//                                 Get.offNamed('/acustomer');
//                               }
//                             },
//                             child: Text(
//                               'Save',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }\


class DCustomerProfile extends StatelessWidget {
  final DCustomerProfileController controller =
      Get.put(DCustomerProfileController());

  DCustomerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          'Customer Profile',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              /// 🔹 Header Card
              // Container(
              //   padding: EdgeInsets.all(16.w),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         radius: 32,
              //         backgroundColor: Colors.blue.shade100,
              //         child: Icon(
              //           Icons.person,
              //           size: 36,
              //           color: Colors.blue,
              //         ),
              //       ),
              //       SizedBox(width: 16.w),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               '${controller.fnameCtrl.text} ${controller.lnameCtrl.text}',
              //               style: TextStyle(
              //                 fontSize: 18.sp,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             SizedBox(height: 4.h),
              //             Text(
              //               controller.phoneCtrl.text,
              //               style: TextStyle(
              //                 fontSize: 14.sp,
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // SizedBox(height: 16.h),

              /// 🔹 Personal Info
              _infoCard(
                title: 'Personal Information',
                children: [
                  _field('First Name', controller.fnameCtrl),
                  _field('Middle Name', controller.mnameCtrl),
                  _field('Last Name', controller.lnameCtrl),
                  _field('Phone', controller.phoneCtrl),
                  _field('Address', controller.addressCtrl),
                ],
              ),

              SizedBox(height: 16.h),

              /// 🔹 Delivery Info
              _infoCard(
                title: 'Delivery Details',
                children: [
                  _field('Quantity (L)', controller.quantityCtrl),
                  _field('Rate', controller.rateCtrl),
                  _field('Milk Type', controller.milkTypeCtrl),
                  _field('Delivery Time', controller.deliveryTimeCtrl),
                ],
              ),

              SizedBox(height: 24.h),

              /// 🔹 Save Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (await controller.save()) {
                      Get.snackbar(
                        "Success",
                        "Customer Details Updated Successfully",
                      );
                      Get.offNamed('/acustomer');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  /// 🔹 Reusable Card
  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }

  /// 🔹 Input Field Wrapper
  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 6.h),
          MyTextfield(
            hinttext: '',
            controller: controller,
          ),
        ],
      ),
    );
  }
}

