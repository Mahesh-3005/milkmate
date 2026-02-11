import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.dcustomer.dart';

// class DCustomer extends StatelessWidget {
//   final controller = Get.put(DCustomerController());
//   DCustomer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   'Customer Details',
//                   style: TextStyle(
//                     fontSize: 30.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 1.h,
//                 decoration: BoxDecoration(color: Colors.grey),
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'First Name',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         controller.firstname.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Middle Name',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         controller.middlename.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Last Name',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         controller.lastname.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Phone',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         controller.phone.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Quantity',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         '${controller.quantity.string} Liter/Day',
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Rate',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         '₹ ${controller.rate.string}',
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Milk Type',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         controller.milktype.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Delivery Time',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => Text(
//                         controller.deliverytime.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'Address',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Obx(
//                     () => Expanded(
//                       flex: 1,
//                       child: Text(
//                         controller.address.value,
//                         style: TextStyle(fontSize: 16.sp),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               !controller.isCustomer.value ?
//               Center(
//                 child: Container(
//                   height: 35.h,
//                   width: 110.w,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: InkWell(
//                       onTap:
//                           () => Get.offNamed(
//                             '/dcustomerprofile',
//                             arguments: {
//                               "id":
//                                   Get.arguments != null
//                                       ? "${Get.arguments['id']}"
//                                       : '',
//                             },
//                           ),
//                       child: Text(
//                         'Edit Details',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ):Container()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class DCustomer extends StatelessWidget {
  final DCustomerController controller = Get.put(DCustomerController());

  DCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              /// Header Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.firstname.value} ${controller.lastname.value}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              controller.phone.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              /// Personal Info Card
              _infoCard(
                title: 'Personal Information',
                children: [
                  _infoRow('First Name', controller.firstname),
                  _infoRow('Middle Name', controller.middlename),
                  _infoRow('Last Name', controller.lastname),
                  _infoRow('Phone', controller.phone),
                  _infoRow('Address', controller.address),
                ],
              ),

              SizedBox(height: 16.h),

              /// Milk Info Card
              _infoCard(
  title: 'Milk Details',
  children: [
    _infoTextRow(
      'Quantity',
      Obx(
        () => Text(
          '${controller.quantity.string} Liter / Day',
        ),
      ),
    ),
    _infoTextRow(
      'Rate',
      Obx(
        () => Text(
          '₹ ${controller.rate.string}',
        ),
      ),
    ),
    _infoRow('Milk Type', controller.milktype),
    _infoRow('Delivery Time', controller.deliverytime),
  ],
),

              SizedBox(height: 24.h),

              /// Edit Button
              Obx(
                () => controller.isCustomer.value
                    ? SizedBox()
                    : SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offNamed(
                              '/dcustomerprofile',
                              arguments: {
                                "id": Get.arguments != null
                                    ? "${Get.arguments['id']}"
                                    : '',
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Edit Details',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

  /// Reusable Card
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

  /// RxString Row
  Widget _infoRow(String label, RxString value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Obx(
              () => Text(
                value.value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Non-Rx Row (Quantity / Rate)
  Widget _infoTextRow(String label, Widget valueWidget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              child: valueWidget,
            ),
          ),
        ],
      ),
    );
  }
}
