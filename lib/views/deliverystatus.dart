import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.deliverystatus.dart';
import 'package:table_calendar/table_calendar.dart';

class DeliveryStatus extends StatelessWidget {
  final controller = Get.put(DeliveryStatusController());
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DeliveryStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Delivery Status',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold
                        // color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ),
                  Container(
                      height: 1.h,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  SizedBox(height: 10.h,),
                  TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2025, 7, 1),
                      lastDay: DateTime.utc(2027, 12, 31),
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (format) {
                        _calendarFormat = format;
                      },
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, date, _) {
                          final isDelivered = controller.deliveryDates.any((d) =>
                              d.year == date.year && d.month == date.month && d.day == date.day);
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: isDelivered ? Colors.green : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isDelivered ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
