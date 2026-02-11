// ...existing code...
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.areport.dart';

// class AReport extends StatelessWidget {
//   final AReportController controller = Get.put(
//     AReportController(),
//   );
//    AReport({super.key});

//   // Modern progress dialog used during PDF generation/saving.
//   void _showProgressDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           child: Center(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).dialogBackgroundColor.withOpacity(0.98),
//                 borderRadius: BorderRadius.circular(12.r),
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12.r, offset: Offset(0, 6.h))],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     width: 36.w,
//                     height: 36.w,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 3.5,
//                       valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Flexible(
//                     child: Text(
//                       message,
//                       style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // NOTE: consolidated flow: choose period, then pick reference date (day/week/month), then Print/Save

//   // Removed month-only helpers; using generic period+date selector instead.

//   /// Generic period selector that prompts for a reference date and then calls the provided callbacks.
//   void _showReportSelector(
//     BuildContext context,
//     AReportController controller,
//     Future<void> Function(ReportPeriod, {DateTime? reference}) onPrint,
//     Future<String?> Function(ReportPeriod, {DateTime? reference}) onSave,
//   ) {
//     ReportPeriod selected = ReportPeriod.daily;
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) {
//         return StatefulBuilder(builder: (c, setState) {
//           return Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Select Report Period', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 12.h),
//                 RadioListTile<ReportPeriod>(
//                   title: Text('Daily'),
//                   value: ReportPeriod.daily,
//                   groupValue: selected,
//                   onChanged: (v) => setState(() => selected = v ?? ReportPeriod.daily),
//                 ),
//                 RadioListTile<ReportPeriod>(
//                   title: Text('Weekly'),
//                   value: ReportPeriod.weekly,
//                   groupValue: selected,
//                   onChanged: (v) => setState(() => selected = v ?? ReportPeriod.weekly),
//                 ),
//                 RadioListTile<ReportPeriod>(
//                   title: Text('Monthly'),
//                   value: ReportPeriod.monthly,
//                   groupValue: selected,
//                   onChanged: (v) => setState(() => selected = v ?? ReportPeriod.monthly),
//                 ),
//                 RadioListTile<ReportPeriod>(
//                   title: Text('Yearly'),
//                   value: ReportPeriod.yearly,
//                   groupValue: selected,
//                   onChanged: (v) => setState(() => selected = v ?? ReportPeriod.yearly),
//                 ),
//                 SizedBox(height: 8.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           Navigator.of(ctx).pop();
//                           final now = DateTime.now();
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: now,
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2100),
//                           );
//                           if (picked == null) return;

//                           // show progress indicator while generating (modern dialog)
//                           _showProgressDialog(context, 'Generating report...');
//                           try {
//                             await onPrint(selected, reference: picked);
//                           } finally {
//                             Navigator.of(context, rootNavigator: true).pop();
//                           }
//                         },
//                         child: Text('Print'),
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () async {
//                           Navigator.of(ctx).pop();
//                           final now = DateTime.now();
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: now,
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2100),
//                           );
//                           if (picked == null) return;

//                           // show progress indicator while saving (modern dialog)
//                           _showProgressDialog(context, 'Saving report...');
//                           String? path;
//                           try {
//                             path = await onSave(selected, reference: picked);
//                           } finally {
//                             Navigator.of(context, rootNavigator: true).pop();
//                           }
//                           Get.snackbar('Saved', path ?? 'Save failed');
//                         },
//                         child: Text('Save'),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12.h),
//               ],
//             ),
//           );
//         });
//       },
//     );
//   }

//   // Profit uses the generic selector via the button below.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Reports',
//                 style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10.h),
//               Container(height: 1.h, color: Colors.grey),
//               SizedBox(height: 16.h),
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 1,
//                   mainAxisSpacing: 12.h,
//                   crossAxisSpacing: 12.w,
//                   childAspectRatio: 3.4,
//                   children: [
//                     ModernButton(
//                       icon: Icons.bar_chart,
//                       label: 'Customer Details Report',
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF667EEA), Color(0xFF64B6FF)],
//                       ),
//                       onTap: () {
//                         controller.printAllCustomersPdf();
//                       },
//                     ),
//                     ModernButton(
//                       icon: Icons.calendar_month,
//                       label: 'Milk Report',
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                       ),
//                       onTap: () {
//                         _showReportSelector(context, controller, controller.printMilkReport, controller.saveMilkReportToFile);
//                       },
//                     ),
//                     // ModernButton(
//                     //   icon: Icons.pie_chart,
//                     //   label: 'Summary',
//                     //   gradient: const LinearGradient(
//                     //     colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                     //   ),
//                     //   onTap: () {/* TODO: navigate */},
//                     // ),
//                     ModernButton(
//                       icon: Icons.download,
//                       label: 'Expense Report',
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
//                       ),
//                       onTap: () { _showReportSelector(context, controller, controller.printExpenseReport, controller.saveExpenseReportToFile); },
//                     ),
//                     ModernButton(
//                       icon: Icons.pie_chart,
//                       label: 'Profit Report',
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF00C9A7), Color(0xFF92FE9D)],
//                       ),
//                       onTap: () { _showReportSelector(context, controller, controller.printProfitReport, controller.saveProfitReportToFile); },
//                     ),
//                     ModernButton(
//                       icon: Icons.summarize,
//                       label: 'Summary Report',
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
//                       ),
//                       onTap: () { _showReportSelector(context, controller, controller.printSummaryReport, controller.saveSummaryReportToFile); },
//                     ),
//                     ModernButton(
//                       icon: Icons.settings,
//                       label: 'Income Report',
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
//                       ),
//                       onTap: () { _showReportSelector(context, controller, controller.printIncomeReport, controller.saveIncomeReportToFile); },
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

// class ModernButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final LinearGradient gradient;
//   final VoidCallback? onTap;

//   const ModernButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.gradient,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16.r),
//         onTap: onTap,
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(16.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.12),
//                 blurRadius: 8.r,
//                 offset: Offset(0, 4.h),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
//             child: Row(
//               children: [
//                 Container(
//                   width: 44.w,
//                   height: 44.w,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.18),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(icon, color: Colors.white, size: 24.sp),
//                 ),
//                 SizedBox(width: 12.w),
//                 Flexible(
//                   fit: FlexFit.tight,
//                   child: AutoSizeText(
//                     label,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     minFontSize: 10.sp,
//                     overflow: TextOverflow.ellipsis,
//                     stepGranularity: 1,
//                   ),
//                 ),
//                 Icon(Icons.chevron_right, color: Colors.white70, size: 20.sp),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




class AReport extends StatelessWidget {
  final AReportController controller = Get.put(AReportController());

  AReport({super.key});

  void _showReportSelector(
    BuildContext context,
    Future<void> Function(ReportPeriod, {DateTime? reference}) onPrint,
    Future<String?> Function(ReportPeriod, {DateTime? reference}) onSave,
  ) {
    ReportPeriod selected = ReportPeriod.daily;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Drag Handle
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  Text(
                    'Select Report Period',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  _periodCard(
                    title: 'Daily',
                    value: ReportPeriod.daily,
                    selected: selected,
                    onTap: () => setState(() => selected = ReportPeriod.daily),
                  ),
                  _periodCard(
                    title: 'Weekly',
                    value: ReportPeriod.weekly,
                    selected: selected,
                    onTap: () => setState(() => selected = ReportPeriod.weekly),
                  ),
                  _periodCard(
                    title: 'Monthly',
                    value: ReportPeriod.monthly,
                    selected: selected,
                    onTap:
                        () => setState(() => selected = ReportPeriod.monthly),
                  ),
                  _periodCard(
                    title: 'Yearly',
                    value: ReportPeriod.yearly,
                    selected: selected,
                    onTap: () => setState(() => selected = ReportPeriod.yearly),
                  ),

                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Expanded(
                        child: _actionButton(
                          label: 'Print',
                          icon: Icons.print,
                          filled: true,
                          onTap: () async {
                            Navigator.pop(ctx);
                            final picked = await _showStyledDatePicker(context);
                            if (picked == null) return;

                            _showLoading(context, 'Generating report...');
                            try {
                              await onPrint(selected, reference: picked);
                            } finally {
                              Get.back();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _actionButton(
                          label: 'Save',
                          icon: Icons.download,
                          filled: false,
                          onTap: () async {
                            Navigator.pop(ctx);
                            final picked = await _showStyledDatePicker(context);
                            if (picked == null) return;

                            _showLoading(context, 'Saving report...');
                            String? path;
                            try {
                              path = await onSave(selected, reference: picked);
                            } finally {
                              Get.back();
                            }
                            Get.snackbar('Saved', path ?? 'Failed');
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<DateTime?> _showStyledDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  // void _showLoading(BuildContext context, String message) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierColor: Colors.black.withOpacity(0.15), // soft dim
  //     builder: (_) {
  //       return Center(
  //         child: Container(
  //           width: 260.w,
  //           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade100, // SAME as app background
  //             borderRadius: BorderRadius.circular(14.r),
  //             border: Border.all(color: Colors.grey.shade300),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               /// Loader
  //               SizedBox(
  //                 width: 26.w,
  //                 height: 26.w,
  //                 child: CircularProgressIndicator(
  //                   strokeWidth: 2.4,
  //                   color: Colors.blue,
  //                 ),
  //               ),

  //               SizedBox(height: 12.h),

  //               /// Text
  //               Text(
  //                 message,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 14.sp,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.blueGrey.shade800,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showLoading(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.18),
    builder: (_) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 270.w,
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Loader
                SizedBox(
                  width: 32.w,
                  height: 32.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.8,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(height: 18.h),

                /// STATUS (NO underline, NO selection tint)
                Text(
                  'PLEASE WAIT',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                    color: Colors.blue.shade600,
                    decoration: TextDecoration.none,
                  ),
                ),

                SizedBox(height: 10.h),

                /// MAIN MESSAGE
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey.shade900,
                    decoration: TextDecoration.none,
                  ),
                ),

                SizedBox(height: 8.h),

                /// SUB MESSAGE
                Text(
                  'Preparing your report securely',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.blueGrey.shade500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  

  Widget _actionButton({
    required String label,
    required IconData icon,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        height: 46.h,
        decoration: BoxDecoration(
          color: filled ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: filled ? Colors.white : Colors.blue),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: filled ? Colors.white : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _periodCard({
    required String title,
    required ReportPeriod value,
    required ReportPeriod selected,
    required VoidCallback onTap,
  }) {
    final isSelected = value == selected;

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.blue, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _periodTile(
    String title,
    ReportPeriod value,
    ReportPeriod selected,
    void Function(void Function()) setState,
  ) {
    return RadioListTile<ReportPeriod>(
      title: Text(title),
      value: value,
      groupValue: selected,
      onChanged: (v) => setState(() => selected = v!),
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// Same header style as Mark Delivered
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          'Reports',
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

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _ReportTile(
              icon: Icons.people,
              title: 'Customer Details Report',
              onTap: controller.printAllCustomersPdf,
            ),
            _ReportTile(
              icon: Icons.calendar_month,
              title: 'Milk Report',
              onTap:
                  () => _showReportSelector(
                    context,
                    controller.printMilkReport,
                    controller.saveMilkReportToFile,
                  ),
            ),
            _ReportTile(
              icon: Icons.money_off,
              title: 'Expense Report',
              onTap:
                  () => _showReportSelector(
                    context,
                    controller.printExpenseReport,
                    controller.saveExpenseReportToFile,
                  ),
            ),
            _ReportTile(
              icon: Icons.pie_chart,
              title: 'Profit Report',
              onTap:
                  () => _showReportSelector(
                    context,
                    controller.printProfitReport,
                    controller.saveProfitReportToFile,
                  ),
            ),
            _ReportTile(
              icon: Icons.summarize,
              title: 'Summary Report',
              onTap:
                  () => _showReportSelector(
                    context,
                    controller.printSummaryReport,
                    controller.saveSummaryReportToFile,
                  ),
            ),
            _ReportTile(
              icon: Icons.attach_money,
              title: 'Income Report',
              onTap:
                  () => _showReportSelector(
                    context,
                    controller.printIncomeReport,
                    controller.saveIncomeReportToFile,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- SIMPLE REPORT TILE ----------
class _ReportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ReportTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.blue.shade600),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
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
  }
}
