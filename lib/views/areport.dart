// ...existing code...
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.areport.dart';

class AReport extends StatelessWidget {
  final AReportController controller = Get.put(
    AReportController(),
  );
   AReport({super.key});

  // Modern progress dialog used during PDF generation/saving.
  void _showProgressDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor.withOpacity(0.98),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12.r, offset: Offset(0, 6.h))],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 36.w,
                    height: 36.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
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

  // NOTE: consolidated flow: choose period, then pick reference date (day/week/month), then Print/Save

  // Removed month-only helpers; using generic period+date selector instead.

  /// Generic period selector that prompts for a reference date and then calls the provided callbacks.
  void _showReportSelector(
    BuildContext context,
    AReportController controller,
    Future<void> Function(ReportPeriod, {DateTime? reference}) onPrint,
    Future<String?> Function(ReportPeriod, {DateTime? reference}) onSave,
  ) {
    ReportPeriod selected = ReportPeriod.daily;
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (c, setState) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Report Period', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 12.h),
                RadioListTile<ReportPeriod>(
                  title: Text('Daily'),
                  value: ReportPeriod.daily,
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v ?? ReportPeriod.daily),
                ),
                RadioListTile<ReportPeriod>(
                  title: Text('Weekly'),
                  value: ReportPeriod.weekly,
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v ?? ReportPeriod.weekly),
                ),
                RadioListTile<ReportPeriod>(
                  title: Text('Monthly'),
                  value: ReportPeriod.monthly,
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v ?? ReportPeriod.monthly),
                ),
                RadioListTile<ReportPeriod>(
                  title: Text('Yearly'),
                  value: ReportPeriod.yearly,
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v ?? ReportPeriod.yearly),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked == null) return;

                          // show progress indicator while generating (modern dialog)
                          _showProgressDialog(context, 'Generating report...');
                          try {
                            await onPrint(selected, reference: picked);
                          } finally {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        child: Text('Print'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked == null) return;

                          // show progress indicator while saving (modern dialog)
                          _showProgressDialog(context, 'Saving report...');
                          String? path;
                          try {
                            path = await onSave(selected, reference: picked);
                          } finally {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                          Get.snackbar('Saved', path ?? 'Save failed');
                        },
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ),
          );
        });
      },
    );
  }

  // Profit uses the generic selector via the button below.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reports',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Container(height: 1.h, color: Colors.grey),
              SizedBox(height: 16.h),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 3.4,
                  children: [
                    ModernButton(
                      icon: Icons.bar_chart,
                      label: 'Customer Details Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF64B6FF)],
                      ),
                      onTap: () {
                        controller.printAllCustomersPdf();
                      },
                    ),
                    ModernButton(
                      icon: Icons.calendar_month,
                      label: 'Milk Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      ),
                      onTap: () {
                        _showReportSelector(context, controller, controller.printMilkReport, controller.saveMilkReportToFile);
                      },
                    ),
                    // ModernButton(
                    //   icon: Icons.pie_chart,
                    //   label: 'Summary',
                    //   gradient: const LinearGradient(
                    //     colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    //   ),
                    //   onTap: () {/* TODO: navigate */},
                    // ),
                    ModernButton(
                      icon: Icons.download,
                      label: 'Expense Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
                      ),
                      onTap: () { _showReportSelector(context, controller, controller.printExpenseReport, controller.saveExpenseReportToFile); },
                    ),
                    ModernButton(
                      icon: Icons.pie_chart,
                      label: 'Profit Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00C9A7), Color(0xFF92FE9D)],
                      ),
                      onTap: () { _showReportSelector(context, controller, controller.printProfitReport, controller.saveProfitReportToFile); },
                    ),
                    ModernButton(
                      icon: Icons.summarize,
                      label: 'Summary Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                      ),
                      onTap: () { _showReportSelector(context, controller, controller.printSummaryReport, controller.saveSummaryReportToFile); },
                    ),
                    ModernButton(
                      icon: Icons.settings,
                      label: 'Income Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                      ),
                      onTap: () { _showReportSelector(context, controller, controller.printIncomeReport, controller.saveIncomeReportToFile); },
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

class ModernButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final LinearGradient gradient;
  final VoidCallback? onTap;

  const ModernButton({
    super.key,
    required this.icon,
    required this.label,
    required this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  fit: FlexFit.tight,
                  child: AutoSizeText(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    minFontSize: 10.sp,
                    overflow: TextOverflow.ellipsis,
                    stepGranularity: 1,
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.white70, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ...existing code...


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AReport extends StatelessWidget {
//   const AReport({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//     Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
//           child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Reports',
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
                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
    
//   }
// }