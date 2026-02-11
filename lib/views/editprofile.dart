import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.editprofile.dart';
import 'package:milklog/others/components/textfield.dart';

// class EditProfilePage extends StatelessWidget {
//   final EditProfilePageController controller = Get.put(
//     EditProfilePageController(),
//   );
//   EditProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         'Edit Profile',
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
//                       'First Name:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(hinttext: '', controller: controller.fnameCtrl),
//                     SizedBox(height: 8.h),
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
//                     SizedBox(height: 8.h),
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
//                     SizedBox(height: 8.h),
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
//                       controller: controller.addressCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Organization Name:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.organizationCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Organization Key:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     MyTextfield(
//                       hinttext: '',
//                       controller: controller.organizationKeyCtrl,
//                     ),
//                     SizedBox(height: 8.h),
//                     Center(
//                       child: InkWell(
//                         onTap: () async {
//                           if (await controller.save()) {
//                             Get.offNamed('/profile');
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


class EditProfilePage extends StatelessWidget {
  final EditProfilePageController controller =
      Get.put(EditProfilePageController());

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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
              /// Personal Details
              _formCard(
                title: 'Personal Details',
                children: [
                  _label('First Name'),
                  MyTextfield(
                    hinttext: 'Enter first name',
                    controller: controller.fnameCtrl,
                  ),
                  _gap(),

                  _label('Middle Name'),
                  MyTextfield(
                    hinttext: 'Enter middle name',
                    controller: controller.mnameCtrl,
                  ),
                  _gap(),

                  _label('Last Name'),
                  MyTextfield(
                    hinttext: 'Enter last name',
                    controller: controller.lnameCtrl,
                  ),
                  _gap(),

                  _label('Address'),
                  MyTextfield(
                    hinttext: 'Enter address',
                    controller: controller.addressCtrl,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              /// Organization Details
              _formCard(
                title: 'Organization Details',
                children: [
                  _label('Organization Name'),
                  MyTextfield(
                    hinttext: 'Enter organization name',
                    controller: controller.organizationCtrl,
                  ),
                  _gap(),

                  _label('Organization Key'),
                  MyTextfield(
                    hinttext: 'Enter organization key',
                    controller: controller.organizationKeyCtrl,
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
                    if (await controller.save()) {
                      Get.offNamed('/profile');
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

  /// Reusable Card
  Widget _formCard({
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

  /// Label
  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  /// Gap
  Widget _gap() => SizedBox(height: 12.h);
}
