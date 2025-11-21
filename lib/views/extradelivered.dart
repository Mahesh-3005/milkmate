import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.extradelivered.dart';

class ExtraDelivered extends StatelessWidget {
  final controller = Get.put(ExtraDeliveredController());
  ExtraDelivered({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.delete<ExtraDeliveredController>(
          force: true,
        ); // ✅ This WILL be triggered on swipe
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 20.w,
              right: 20.w,
              bottom: 20.h,
            ),
            child: Center(
              child:
              //         Column(
              //           children: [
              //             Obx(() => AnimatedSwitcher(
              //             duration: Duration(milliseconds: 400),
              //             transitionBuilder: (child, animation) {
              //               final offsetAnimation = Tween<Offset>(
              //                 begin: Offset(1.0, 0.0), // from right
              //                 end: Offset(0.0, 0.0),   // to center
              //               ).animate(animation);
              //               return SlideTransition(position: offsetAnimation, child: child);
              //             },
              //             child: Container(
              //               key: ValueKey(controller.index.value), // important!
              //               alignment: Alignment.center,
              //               width: 200,
              //               height: 200,
              //               color: controller.index.value.isEven
              //                   ? Colors.blue
              //                   : Colors.green,
              //               child: Text(
              //                 "Content ${controller.index.value}",
              //                 style: TextStyle(color: Colors.white, fontSize: 20),
              //               ),
              //             ),
              //                         )),
              //              FloatingActionButton(
              //   onPressed: controller.next,
              //   child: Icon(Icons.navigate_next),
              // ),
              //           ],
              //         ),
              Column(
                children: [
                  Text(
                    'Extra Delivered',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedDate.value
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  controller
                                      .selectedDate
                                      .value, // default to today
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2030),
                            );

                            if (picked != null) {
                              controller.setDate(picked);
                            }
                          },
                          icon: Icon(Icons.calendar_month_sharp),
                        ),
                        // TextButton(onPressed: () => controller.isTodayMarked(), child: Text(
                        //     'Check',
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),)
                      ],
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: controller.clearAll,
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: controller.selectAll,
                      //   child: const Text(
                      //     'Select All',
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Expanded(
                    child: Obx(
                      () => AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        transitionBuilder: (child, animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: Offset(1.0, 0.0), // from right
                            end: Offset(0.0, 0.0), // to center
                          ).animate(animation);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        child:
                            controller.index.value == 0
                                ? CustomerListView(
                                  key: const ValueKey(0),
                                  controller: controller,
                                )
                                : SelectedCustomerListView(
                                  key: const ValueKey(1),
                                  controller: controller,
                                ),
                      ),
                    ),
                  ),
                  // FloatingActionButton(
                  //   onPressed: () {
                  //     controller.getNewCustomerList();
                  //     controller.next();
                  //   },
                  //   child: Icon(Icons.arrow_forward_rounded),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerListView extends StatelessWidget {
  final ExtraDeliveredController controller;
  const CustomerListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
              itemCount: controller.customerList.length,
              itemBuilder: (context, index) {
                final customer = controller.customerList[index];
                return Obx(() {
                  final isSel = controller.isSelected(index);

                  return Card(
                    child: ListTile(
                      dense: true,
                      title: Text(
                        '${index + 1}. ${customer.firstName} ${customer.lastName}',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () => controller.toggle(index, customer.id),
                      trailing: _buildCheckBox(isSel),
                    ),
                  );
                });
              },
            );
          }),
        ),
        FloatingActionButton(
          onPressed: () {
            if (controller.getNewCustomerList()) {
              controller.next();
            }
          },
          backgroundColor: Colors.blue,
          
          child: Icon(Icons.arrow_forward_rounded,color: Colors.white,weight: 20),
        ),
      ],
    );
  }

  Widget _buildCheckBox(bool isSel) {
    return Container(
      width: 22.w,
      height: 20.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSel ? Colors.purple.shade300 : Colors.grey,
          width: 2,
        ),
        color:
            isSel
                ? Colors.purple.shade300.withOpacity(0.2)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child:
          isSel
              ? const Icon(Icons.check, size: 18, color: Colors.purple)
              : const SizedBox.shrink(),
    );
  }
}

class SelectedCustomerListView extends StatelessWidget {
  final ExtraDeliveredController controller;
  const SelectedCustomerListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
              itemCount: controller.newCustomerList.length,
              itemBuilder: (context, index) {
                final customer = controller.newCustomerList[index];

                return Card(
                  child: ListTile(
                    dense: true,
                    title: Text(
                      '${index + 1}. ${customer.firstName} ${customer.lastName}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity : ', style: TextStyle(fontSize: 14.sp)),
                        Expanded(
                          // 👈 important so TextField takes remaining space
                          child: TextField(
                            keyboardType: TextInputType.number,
                            cursorHeight: 16.h,
                            decoration: InputDecoration(
                              isDense: true, // compact look
                              hintText: "Enter liters",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.sp,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              // prefixIcon: Icon(Icons.local_drink, color: Colors.purple),
                              suffixText: "Litre", // liters
                            ),
                            onChanged: (val) {
                              final qty = double.tryParse(val) ?? 0;
                              controller.setExtraQty(customer.id, qty);
                            },
                          ),
                        ),
                      ],
                    ),
                    // onTap: () => controller.toggle(index, customer.id),
                    // trailing: _buildCheckBox(isSel),
                  ),
                );
              },
            );
          }),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.saveExtraDeliveries()) {
              Get.snackbar("Success", "Extra Deliveries Saved Successfully");
              Get.offAllNamed('/home');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // button color
            foregroundColor: Colors.white, // text/icon color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            elevation: 4, // shadow
          ),
          child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // Widget _buildCheckBox(bool isSel) {
  //   return Container(
  //     width: 22.w,
  //     height: 20.h,
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: isSel ? Colors.purple.shade300 : Colors.grey,
  //         width: 2,
  //       ),
  //       color:
  //           isSel
  //               ? Colors.purple.shade300.withOpacity(0.2)
  //               : Colors.transparent,
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //     child:
  //         isSel
  //             ? const Icon(Icons.check, size: 18, color: Colors.purple)
  //             : const SizedBox.shrink(),
  //   );
  // }
}
