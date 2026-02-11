import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.acustomer.dart';

// class ACustomer extends StatelessWidget {
//   final controller = Get.put(ACustomerController());
//   ACustomer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  WillPopScope(
//       onWillPop: () async {
//         await Get.delete<ACustomerController>(
//           force: true,
//         ); // ✅ This WILL be triggered on swipe
//         return true; // Allow back navigation
//       },
//       child:
//     Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
//           child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   'All Customers',
//                   style: TextStyle(
//                     fontSize: 30.sp,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 Container(
//                       height: 1.h,
//                       decoration: BoxDecoration(color: Colors.grey),
//                     ),
//                 SizedBox(height: 10.h),
//                  Expanded(
//                     child: ListView.builder(
//                       itemCount: controller.customerList.length,
//                       itemBuilder: (context, index) {
//                         var customer = controller.customerList[index];
//                         return 
//                         Column(
//                           children: [
//                             Card(
//                               // color: Colors.grey[100],
//                               child: InkWell(
//                                 onTap:
//                                     () => Get.toNamed(
//                                       '/dcustomer',
//                                       arguments: {'id': customer.id},
//                                     ),
//                                 child: ListTile(
//                                   dense: true,
//                                   title: Text(
//                                     "${customer.firstName} ${customer.middleName} ${customer.lastName}",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.blueGrey.shade600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 3.h),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     )
//     );
//   }
// }



// class ACustomer extends StatelessWidget {
//   final controller = Get.put(ACustomerController());
//   ACustomer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await Get.delete<ACustomerController>(force: true);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade100,

//         /// 🔹 Header same as Mark Delivered
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.grey.shade100,
//           centerTitle: true,
//           title: Text(
//             'All Customers',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Get.back(),
//           ),
//         ),

//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//             child: Column(
//               children: [
//                 /// 🔹 Customer List
//                 Expanded(
//                   child: ListView.separated(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: controller.customerList.length,
//                     separatorBuilder: (_, __) => SizedBox(height: 6.h),
//                     itemBuilder: (context, index) {
//                       final customer = controller.customerList[index];

//                       return Card(
//                         elevation: 3,
//                         shadowColor: Colors.black12,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(14),
//                           onTap: () => Get.toNamed(
//                             '/dcustomer',
//                             arguments: {'id': customer.id},
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 14.h,
//                               horizontal: 12.w,
//                             ),
//                             child: Row(
//                               children: [
//                                 /// Index badge
//                                 Container(
//                                   width: 32,
//                                   height: 32,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.shade50,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Text(
//                                     '${index + 1}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ),

//                                 SizedBox(width: 12.w),

//                                 /// Customer name
//                                 Expanded(
//                                   child: Text(
//                                     "${customer.firstName} ${customer.middleName} ${customer.lastName}",
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.blueGrey.shade700,
//                                     ),
//                                   ),
//                                 ),

//                                 Icon(
//                                   Icons.chevron_right_rounded,
//                                   size: 28,
//                                   color: Colors.grey.shade400,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ACustomer extends StatelessWidget {
//   final controller = Get.put(ACustomerController());
//   ACustomer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await Get.delete<ACustomerController>(force: true);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade100,

//         /// Header – same as Mark Delivered
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.grey.shade100,
//           centerTitle: true,
//           title: Text(
//             'All Customers',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Get.back(),
//           ),
//         ),

//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//             child: ListView.separated(
//               physics: const BouncingScrollPhysics(),
//               itemCount: controller.customerList.length,
//               separatorBuilder: (_, __) => SizedBox(height: 8.h),
//               itemBuilder: (context, index) {
//                 final customer = controller.customerList[index];

//                 return InkWell(
//                   borderRadius: BorderRadius.circular(14),
//                   onTap: () => Get.toNamed(
//                     '/dcustomer',
//                     arguments: {'id': customer.id},
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 14.w,
//                       vertical: 14.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         /// Left Accent + Index
//                         Container(
//                           width: 36,
//                           height: 36,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade50,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             '${index + 1}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue.shade600,
//                             ),
//                           ),
//                         ),

//                         SizedBox(width: 14.w),

//                         /// Customer Name
//                         Expanded(
//                           child: Text(
//                             "${customer.firstName} ${customer.middleName} ${customer.lastName}",
//                             style: TextStyle(
//                               fontSize: 15.5.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.blueGrey.shade800,
//                             ),
//                           ),
//                         ),

//                         /// Arrow
//                         Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           size: 16,
//                           color: Colors.grey.shade400,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ACustomer extends StatelessWidget {
  final controller = Get.put(ACustomerController());
  ACustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.delete<ACustomerController>(force: true);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        /// Header – same as Mark Delivered
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          centerTitle: true,
          title: Text(
            'All Customers',
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

        /// 🔵 Add Customer Button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          elevation: 4,
          onPressed: () => Get.toNamed('/addcustomer'),
          child: const Icon(Icons.add, color: Colors.white),
        ),

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.customerList.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final customer = controller.customerList[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Get.toNamed(
                    '/dcustomer',
                    arguments: {'id': customer.id},
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        /// Index Badge
                        Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),

                        SizedBox(width: 14.w),

                        /// Customer Name
                        Expanded(
                          child: Text(
                            "${customer.firstName} ${customer.middleName} ${customer.lastName}",
                            style: TextStyle(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey.shade800,
                            ),
                          ),
                        ),

                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
