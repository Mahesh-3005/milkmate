import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.xadminDetail.dart';

// class XAdminDetail extends StatelessWidget {
//   const XAdminDetail({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final XAdminDetailController controller = Get.put(XAdminDetailController());

//     return Scaffold(
//       // appBar: AppBar(title: const Text('Admin Details')),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text('Admin Details', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
//                 ),
//                 Container(height: 1.h, decoration: BoxDecoration(color: Colors.grey)),
//                 SizedBox(height: 10.h),

//                 Obx(() {
//                   final admin = controller.admin.value;
//                   if (admin == null) return Center(child: Padding(padding: EdgeInsets.all(12.w), child: Text('No admin found')));

//                   Widget row(String label, String value) {
//                     return Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(flex: 1, child: Text(label, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))),
//                             Expanded(flex: 1, child: Text(value, style: TextStyle(fontSize: 16.sp))),
//                           ],
//                         ),
//                         SizedBox(height: 10.h),
//                       ],
//                     );
//                   }

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       row('First Name', admin.firstName),
//                       row('Middle Name', admin.middleName),
//                       row('Last Name', admin.lastName),
//                       row('Phone', admin.phone),
//                       row('Address', admin.address.isNotEmpty ? admin.address : '-'),
//                       row('Organization Name', controller.organizatioName.value),
//                       // row('Created', '${admin.createdAt.toLocal()}'.split('.')[0]),
//                       SizedBox(height: 20.h),
//                     ],
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class XAdminDetail extends StatelessWidget {
  const XAdminDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(XAdminDetailController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Obx(() {
            final admin = controller.admin.value;

            if (admin == null) {
              return const Center(child: Text("No admin found"));
            }

            return Column(
              children: [
                /// 🔹 Header (same as profile)
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
                        child: const Icon(
                          Icons.admin_panel_settings,
                          size: 36,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${admin.firstName} ${admin.lastName}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              controller.organizatioName.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// 🔹 Personal Info
                _infoCard(
                  title: 'Personal Information',
                  children: [
                    _infoRow('First Name', admin.firstName),
                    _infoRow('Middle Name', admin.middleName),
                    _infoRow('Last Name', admin.lastName),
                    _infoRow('Phone', admin.phone),
                  ],
                ),

                SizedBox(height: 16.h),

                /// 🔹 Organization Info
                _infoCard(
                  title: 'Organization',
                  children: [
                    _infoRow(
                        'Organization Name',
                        controller.organizatioName.value),
                    _infoRow('Address',
                        admin.address.isNotEmpty ? admin.address : '-'),
                  ],
                ),

                SizedBox(height: 24.h),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// 🔹 SAME card as Profile
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

  /// 🔹 SIMPLE row (no Rx needed here)
  Widget _infoRow(String label, String value) {
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
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
