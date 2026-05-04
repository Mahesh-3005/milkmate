import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.homepage.dart';

// class HomePage extends StatelessWidget {
//   final HomePageController controller = Get.put(HomePageController());
//   HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // final prefs = await SharedPreferences.getInstance();
//         // await prefs.clear();
//         return false; // Allow back navigation
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Welcome',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       height: 0.2.h,
//                       color: Colors.blueGrey.shade900,
//                     ),
//                   ),
//                   Obx(
//                     () => Text(
//                       controller.name.value,
//                       style: TextStyle(
//                         fontSize: 25.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 1.h,
//                     decoration: BoxDecoration(color: Colors.grey),
//                   ),
//                   SizedBox(height: 20.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         height: 100.h,
//                         width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.sp),
//                           color: Colors.grey[300],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Delivered',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.blueGrey.shade600,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(),
//                                   Text(
//                                     '${controller.delivered}',
//                                     style: TextStyle(
//                                       fontSize: 30.sp,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.blueGrey.shade800,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 100.h,
//                         width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.sp),
//                           color: Colors.grey[300],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Customer',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.blueGrey.shade600,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(),
//                                   Obx(
//                                     () => Text(
//                                       '${controller.customerCount}',
//                                       style: TextStyle(
//                                         fontSize: 30.sp,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.blueGrey.shade800,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () => Get.toNamed('/addcustomer'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Add \nCustomer',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => Get.toNamed('/profile'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'My Profile',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () => Get.toNamed('/acustomer'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Customer \nDetails',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => Get.toNamed('/areport'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Reports',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // InkWell(
//                       //   onTap: () {
//                       //     Get.toNamed('/abill');
//                       //     // DateTime fromDate = DateTime(2025, 9, 9);
//                       //     // DateTime toDate = DateTime(2025, 9, 13);
//                       //     //  controller.generateMatrixReport(
//                       //     //   fromDate,
//                       //     //   toDate,
//                       //     // );
//                       //   },
//                       //   child: Container(
//                       //     height: 70.h,
//                       //     width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                       //     decoration: BoxDecoration(
//                       //       borderRadius: BorderRadius.circular(20.sp),
//                       //       color: Colors.deepPurple[300],
//                       //     ),
//                       //     child: Column(
//                       //       mainAxisAlignment: MainAxisAlignment.center,
//                       //       children: [
//                       //         Text(
//                       //           'Generate \nBill',
//                       //           style: TextStyle(
//                       //             fontSize: 20.sp,
//                       //             fontWeight: FontWeight.bold,
//                       //             color: Colors.white,
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () => Get.toNamed('/adelivered'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Milk \nDelivered',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => Get.toNamed('/extradelivered'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Extra \nDelivered',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [

//                       InkWell(
//                         onTap: () => Get.toNamed('/aincome'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Income',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => Get.toNamed('/aexpense'),
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Expenses',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Get.toNamed('/abill');
//                           // DateTime fromDate = DateTime(2025, 9, 9);
//                           // DateTime toDate = DateTime(2025, 9, 13);
//                           //  controller.generateMatrixReport(
//                           //   fromDate,
//                           //   toDate,
//                           // );
//                         },
//                         child: Container(
//                           height: 70.h,
//                           width: (MediaQuery.sizeOf(context).width / 5) * 2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.sp),
//                             color: Colors.deepPurple[300],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Generate \nBill',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                     ],
//                   ),

//                   SizedBox(height: 30.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Center(
//                         child: InkWell(
//                           onTap: () async {
//                             await controller.sync();
//                           },
//                           child: Container(
//                             height: 35.h,
//                             width: 110.w,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'Sync',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: InkWell(
//                           onTap: () async {
//                             await controller.logout();
//                           },
//                           child: Container(
//                             height: 35.h,
//                             width: 110.w,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'logout',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class HomePage extends StatelessWidget {
  final HomePageController controller = Get.put(HomePageController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? MilkLogColors.darkBg : MilkLogColors.creamBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───────── Header + Menu ─────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.name.value,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _openMenu(context),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// ───────── Today Delivery ─────────
              GestureDetector(
                onTap: () => Get.toNamed('/adelivered'),
                child: _Card(
                  gradient: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Delivery",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Obx(() {
                        final total = controller.customerCount.value;
                        final delivered = controller.delivered.value;
                        final pending = total - delivered;
                        final progress = total == 0 ? 0.0 : delivered / total;

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _pill("Delivered", delivered),
                                _pill("Pending", pending),
                              ],
                            ),
                            const SizedBox(height: 14),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 10,
                                backgroundColor: Colors.white.withOpacity(0.4),
                                valueColor: const AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),

              /// Extra delivery (secondary, subtle)
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed('/extradelivered'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Extra delivery"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MilkLogColors.primary,
                    side: const BorderSide(color: MilkLogColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              // const SizedBox(height: 24),

              // /// ───────── Financial Snapshot ─────────
              // Row(
              //   children: [
              //     Expanded(
              //       child: _StatCard(
              //         title: "Today’s Income",
              //         value: 100.obs,
              //         prefix: "₹",
              //       ),
              //     ),
              //     const SizedBox(width: 12),
              //     Expanded(
              //       child: _StatCard(
              //         title: "This Month",
              //         value: 100.obs,
              //         prefix: "₹",
              //       ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 32),

              /// ───────── Quick Actions ─────────
              const Text(
                "Quick actions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.5,
                children: [
                  _QuickTile(
                    "Customers",
                    Icons.people,
                    () => Get.toNamed('/acustomer'),
                  ),
                  _QuickTile(
                    "Reports",
                    Icons.bar_chart,
                    () => Get.toNamed('/areport'),
                  ),
                  _QuickTile(
                    "Income",
                    Icons.trending_up,
                    () => Get.toNamed('/aincome'),
                  ),
                  _QuickTile(
                    "Expenses",
                    Icons.money_off,
                    () => Get.toNamed('/aexpense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ───────── Bottom Menu ─────────
  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _menuItem(
                icon: Icons.admin_panel_settings,
                text: "Admin / Organization",
                onTap: () {
                  Get.back(); // ✅ close bottom sheet
                  Get.toNamed('/profile');
                },
              ),

              Obx(
                () => _menuItem(
                  icon: Icons.sync,
                  text: "Sync data",
                  badge: controller.pendingSyncCount.value,
                  onTap: () async {
                    Get.back(); // ✅ close bottom sheet
                    await controller.sync();
                  },
                ),
              ),

              const Divider(height: 24),

              _menuItem(
                icon: Icons.logout,
                text: "Logout",
                danger: true,
                onTap: () {
                  Get.back(); // ✅ close bottom sheet
                  _confirmLogout();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    int badge = 0,
    bool danger = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            color: danger ? Colors.red : MilkLogColors.primary,
            size: 26,
          ),
          if (badge > 0)
            Positioned(
              right: -6,
              top: -6,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.red,
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: danger ? Colors.red : null,
        ),
      ),
    );
  }

  void _confirmLogout() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: MilkLogColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: MilkLogColors.primary,
                  size: 26,
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                "Confirm logout",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        await controller.sync();
                        await controller.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: MilkLogColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

/// ───────── Colors ─────────

class MilkLogColors {
  static const primary = Color(0xFF1E88E5);
  static const accent = Color(0xFF64B5F6);
  static const creamBg = Color(0xFFF5F7FA);
  static const darkBg = Color(0xFF0E1A24);
}

/// ───────── Widgets ─────────

class _Card extends StatelessWidget {
  final Widget child;
  final bool gradient;

  const _Card({required this.child, this.gradient = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient:
            gradient
                ? const LinearGradient(
                  colors: [MilkLogColors.primary, MilkLogColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        color: gradient ? null : Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

Widget _pill(String label, int value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.25),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      "$label: $value",
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}

class _StatCard extends StatelessWidget {
  final String title;
  final RxInt value;
  final String prefix;

  const _StatCard({
    required this.title,
    required this.value,
    required this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 10),
            Text(
              "$prefix${value.value}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickTile(this.label, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: MilkLogColors.primary),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
