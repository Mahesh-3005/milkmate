import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.xadminDetail.dart';

class XAdminDetail extends StatelessWidget {
  const XAdminDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final XAdminDetailController controller = Get.put(XAdminDetailController());

    return Scaffold(
      // appBar: AppBar(title: const Text('Admin Details')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Admin Details', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                ),
                Container(height: 1.h, decoration: BoxDecoration(color: Colors.grey)),
                SizedBox(height: 10.h),

                Obx(() {
                  final admin = controller.admin.value;
                  if (admin == null) return Center(child: Padding(padding: EdgeInsets.all(12.w), child: Text('No admin found')));

                  Widget row(String label, String value) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text(label, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))),
                            Expanded(flex: 1, child: Text(value, style: TextStyle(fontSize: 16.sp))),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      row('First Name', admin.firstName),
                      row('Middle Name', admin.middleName),
                      row('Last Name', admin.lastName),
                      row('Phone', admin.phone),
                      row('Address', admin.address.isNotEmpty ? admin.address : '-'),
                      row('Organization Name', controller.organizatioName.value),
                      // row('Created', '${admin.createdAt.toLocal()}'.split('.')[0]),
                      SizedBox(height: 20.h),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
