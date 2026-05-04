import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.deliverystatus.dart';
import 'package:table_calendar/table_calendar.dart';

import '../others/components/colors.dart';

// class DeliveryStatus extends StatelessWidget {
//   final controller = Get.put(DeliveryStatusController());
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DeliveryStatus({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Text(
//                       'Delivery Status',
//                       style: TextStyle(
//                         fontSize: 30.sp,
//                         fontWeight: FontWeight.bold
//                         // color: Colors.blueGrey.shade900,
//                       ),
//                     ),
//                   ),
//                   Container(
//                       height: 1.h,
//                       decoration: BoxDecoration(color: Colors.grey),
//                     ),
//                   SizedBox(height: 10.h,),
//                   TableCalendar(
//                       focusedDay: DateTime.now(),
//                       firstDay: DateTime.utc(2025, 7, 1),
//                       lastDay: DateTime.utc(2027, 12, 31),
//                       calendarFormat: _calendarFormat,
//                       onFormatChanged: (format) {
//                         _calendarFormat = format;
//                       },
//                       calendarBuilders: CalendarBuilders(
//                         defaultBuilder: (context, date, _) {
//                           final isDelivered = controller.deliveryDates.any((d) =>
//                               d.year == date.year && d.month == date.month && d.day == date.day);
//                           return Center(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 // color: isDelivered ? Colors.green : Colors.white,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: Text(
//                                   date.day.toString(),
//                                   style: TextStyle(
//                                     fontSize: 18.sp,
//                                     fontWeight: FontWeight.w600,
//                                     color: isDelivered ? Colors.green : Colors.red,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
                  
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class DeliveryStatus extends StatelessWidget {
  final controller = Get.put(DeliveryStatusController());

  DeliveryStatus({super.key});

  final _calendarFormat = Rx<CalendarFormat>(CalendarFormat.month);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? MilkLogColors.darkBg : MilkLogColors.creamBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───────── Header ─────────
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Delivery Status",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// ───────── Summary Card ─────────
              _Card(
                gradient: true,
                child: Obx(() {
                  final total = controller.deliveryDates.length;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Deliveries",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$total days delivered",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 20),

              /// ───────── Calendar Card ─────────
              _Card(
                child: Obx(() {
                  return TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2025, 7, 1),
                    lastDay: DateTime.utc(2027, 12, 31),

                    calendarFormat: _calendarFormat.value,
                    onFormatChanged: (format) {
                      _calendarFormat.value = format;
                    },

                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      formatButtonDecoration: BoxDecoration(
                        color: MilkLogColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      formatButtonTextStyle: const TextStyle(
                        color: MilkLogColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: MilkLogColors.primary.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: MilkLogColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),

                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, date, _) {
                        final isDelivered =
                            controller.deliveryDates.any((d) =>
                                d.year == date.year &&
                                d.month == date.month &&
                                d.day == date.day);

                        return Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isDelivered
                                ? MilkLogColors.primary.withOpacity(0.15)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDelivered
                                    ? MilkLogColors.primary
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              /// ───────── Legend ─────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _legendDot(MilkLogColors.primary, "Delivered"),
                  const SizedBox(width: 16),
                  _legendDot(Colors.grey, "No Delivery"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ───────── Legend Widget ─────────
  Widget _legendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}

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