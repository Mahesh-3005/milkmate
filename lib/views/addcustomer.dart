import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.addcustomer.dart';
import 'package:milklog/others/components/textfield.dart';

// class AddCustomer extends StatelessWidget {
//   final controller = Get.put(AddCustomerController());
//   AddCustomer({super.key});

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
//                         'Add Customer',
//                         style: TextStyle(
//                           fontSize: 30.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 1.h,
//                       decoration: BoxDecoration(color: Colors.grey),
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'First Name :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(hinttext: '', controller: controller.fnameCtrl),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Middle Name :',
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
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Last Name :',
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
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Phone :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       type: TextInputType.number,
//                       hinttext: '',
//                       controller: controller.phoneCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Address :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.addressCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Quantity :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       type: TextInputType.number,
//                       hinttext: 'Ex. 1/1.5',
//                       controller: controller.quantityCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Rate :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       type: TextInputType.number,
//                       hinttext: 'Ex. 75/80.5',
//                       controller: controller.rateCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Milk Type :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: 'Ex. Cow/Buffalo',
//                       controller: controller.milkTypeCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Delivery Time :',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: 'Ex. Morning/Evening',
//                       controller: controller.deliveryTimeCtrl,
//                     ),
//                     SizedBox(height: 10.h),
//                     Center(
//                       child: InkWell(
//                         onTap: () async {
//                           if (await controller.saveCustomer()) {
//                             Get.offNamed('/home');
//                           }
//                         },
//                         child: Container(
//                           height: 35.h,
//                           width: 110.w,
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Save',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
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
// }

class AddCustomer extends StatelessWidget {
  final controller = Get.put(AddCustomerController());
  AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// Header – consistent with app
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          'Add Customer',
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
              /// Customer Info
              _infoCard(
                title: 'Customer Information',
                children: [
                  _field(
                    label: 'First Name',
                    controller: controller.fnameCtrl,
                  ),
                  _field(
                    label: 'Middle Name',
                    controller: controller.mnameCtrl,
                  ),
                  _field(
                    label: 'Last Name',
                    controller: controller.lnameCtrl,
                  ),
                  _field(
                    label: 'Phone',
                    controller: controller.phoneCtrl,
                    keyboard: TextInputType.number,
                  ),
                  _field(
                    label: 'Address',
                    controller: controller.addressCtrl,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              /// Milk Info
              _infoCard(
                title: 'Milk Details',
                children: [
                  _field(
                    label: 'Quantity (Liter / Day)',
                    controller: controller.quantityCtrl,
                    hint: 'Ex. 1 / 1.5',
                    keyboard: TextInputType.number,
                  ),
                  _field(
                    label: 'Rate',
                    controller: controller.rateCtrl,
                    hint: 'Ex. 75 / 80.5',
                    keyboard: TextInputType.number,
                  ),
                  _field(
                    label: 'Milk Type',
                    controller: controller.milkTypeCtrl,
                    hint: 'Cow / Buffalo',
                  ),
                  _field(
                    label: 'Delivery Time',
                    controller: controller.deliveryTimeCtrl,
                    hint: 'Morning / Evening',
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (await controller.saveCustomer()) {
                      Get.offNamed('/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Save Customer',
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

  /// Reusable Field
  Widget _field({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboard,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
