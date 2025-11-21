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

  Future<void> _selectDateAndAction(BuildContext context, AReportController controller, ReportPeriod period) async {
    // Pick a date (daily -> date; weekly -> any date within week; monthly -> any date in month)
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;

    // After picking date, show action sheet to Print or Save
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Selected: ${picked.day}/${picked.month}/${picked.year}', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.printMilkReport(period, reference: picked);
                        Navigator.of(context).pop();
                      },
                      child: Text('Print'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final path = await controller.saveMilkReportToFile(period, reference: picked);
                        Navigator.of(context).pop();
                        if (path != null) Get.snackbar('Saved', path);
                        else Get.snackbar('Error', 'Failed to save PDF');
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
      },
    );
  }

  void _showReportSelector(BuildContext context, AReportController controller) {
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
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.printMilkReport(selected);
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Print'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final path = await controller.saveMilkReportToFile(selected);
                          Navigator.of(ctx).pop();
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
                      icon: Icons.calendar_today,
                      label: 'Daily Milk Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFB86B), Color(0xFFFF6B6B)],
                      ),
                      onTap: () {
                        _selectDateAndAction(context, controller, ReportPeriod.daily);
                      },
                    ),
                    ModernButton(
                      icon: Icons.event_note,
                      label: 'Weekly Milk Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                      ),
                      onTap: () {
                        _selectDateAndAction(context, controller, ReportPeriod.weekly);
                      },
                    ),
                    ModernButton(
                      icon: Icons.calendar_month,
                      label: 'Monthly Milk Report',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      ),
                      onTap: () {
                        _selectDateAndAction(context, controller, ReportPeriod.monthly);
                      },
                    ),
                    ModernButton(
                      icon: Icons.pie_chart,
                      label: 'Summary',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      ),
                      onTap: () {/* TODO: navigate */},
                    ),
                    ModernButton(
                      icon: Icons.download,
                      label: 'Export',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
                      ),
                      onTap: () {/* TODO: action */},
                    ),
                    ModernButton(
                      icon: Icons.settings,
                      label: 'Settings',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                      ),
                      onTap: () {/* TODO: navigate */},
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