import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/controller/ct.aexpense.dart';

// class AExpense extends StatelessWidget {
//   const AExpense({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AExpenseController());
//     final colorScheme = Theme.of(context).colorScheme;
//     final _formKey = GlobalKey<FormState>();

//     InputDecoration _fieldDecoration({required String label, IconData? icon, String? hint}) {
//       return InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: icon != null ? Icon(icon, color: colorScheme.primary) : null,
//         filled: true,
//         fillColor: Theme.of(context).colorScheme.surface,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//       );
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         title: const Text('Add Expense'),
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         foregroundColor: colorScheme.onBackground,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 720),
//               child: Column(
//                 children: [
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     elevation: 6,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Header
//                             Row(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: colorScheme.primary.withOpacity(0.12),
//                                   ),
//                                   padding: const EdgeInsets.all(12),
//                                   child: Icon(Icons.receipt_long, color: colorScheme.primary),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Add Expense', style: Theme.of(context).textTheme.titleLarge),
//                                     const SizedBox(height: 4),
//                                     Text('Record a new expense quickly', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 18),

//                             // Title field
//                             TextFormField(
//                               initialValue: controller.title.value,
//                               decoration: _fieldDecoration(label: 'Title', icon: Icons.note_add, hint: 'Feed, Repair, Salary...'),
//                               onChanged: (v) => controller.title.value = v,
//                               validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
//                             ),
//                             const SizedBox(height: 14),

//                             // Amount (with rupee prefix)
//                             TextFormField(
//                               initialValue: controller.amount.value,
//                               keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                               decoration: _fieldDecoration(label: 'Amount', icon: Icons.currency_rupee, hint: '0.00').copyWith(
//                                 prefixStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w600),
//                               ),
//                               onChanged: (v) => controller.amount.value = v,
//                               validator: (v) {
//                                 if (v == null || v.trim().isEmpty) return 'Enter amount';
//                                 final n = double.tryParse(v);
//                                 if (n == null) return 'Invalid number';
//                                 if (n <= 0) return 'Amount must be > 0';
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 12),
//                             Obx(() => DropdownButtonFormField<String>(
//                                   value: controller.category.value.isEmpty ? null : controller.category.value,
//                                   decoration: _fieldDecoration(label: 'Category', icon: Icons.category),
//                                   items: const [
//                                     'Feed',
//                                     'Medicine',
//                                     'Salary',
//                                     'Transport',
//                                     'Repair',
//                                     'Other',
//                                   ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                                   onChanged: (v) => controller.category.value = v ?? '',
//                                   validator: (v) => (v == null || v.isEmpty) ? 'Select category' : null,
//                                 )),
//                             const SizedBox(height: 14),

//                             // Date picker
//                             Obx(() {
//                               final dt = controller.date.value;
//                               final label = '${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}';
//                               return InkWell(
//                                 onTap: () async {
//                                   final picked = await showDatePicker(
//                                     context: context,
//                                     initialDate: dt,
//                                     firstDate: DateTime(2020),
//                                     lastDate: DateTime(2035),
//                                   );
//                                   if (picked != null) controller.date.value = picked;
//                                 },
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: InputDecorator(
//                                   decoration: _fieldDecoration(label: 'Date', icon: Icons.calendar_today),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(label, style: Theme.of(context).textTheme.bodyLarge),
//                                       const Icon(Icons.keyboard_arrow_down),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                             const SizedBox(height: 14),

//                             // Actions
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: OutlinedButton(
//                                     style: OutlinedButton.styleFrom(
//                                       padding: const EdgeInsets.symmetric(vertical: 14),
//                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                                     ),
//                                     onPressed: () {
//                                       controller.title.value = '';
//                                       controller.amount.value = '';
//                                       controller.category.value = '';
//                                       controller.date.value = DateTime.now();
//                                     },
//                                     child: const Text('Clear'),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Obx(() {
//                                     final loading = controller.isLoading.value;
//                                     return SizedBox(
//                                       height: 52,
//                                       child: GestureDetector(
//                                         onTap: loading
//                                             ? null
//                                             : () {
//                                                 if (_formKey.currentState?.validate() ?? false) {
//                                                   controller.saveExpense();
//                                                   Get.snackbar("Success", "Expense added successfully!");

//                                                 }
//                                               },
//                                         child: AnimatedContainer(
//                                           duration: const Duration(milliseconds: 200),
//                                           decoration: BoxDecoration(
//                                             gradient: loading
//                                                 ? null
//                                                 : LinearGradient(colors: [colorScheme.primary, colorScheme.primaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight),
//                                             color: loading ? Colors.grey.shade400 : null,
//                                             borderRadius: BorderRadius.circular(12),
//                                             boxShadow: loading
//                                                 ? []
//                                                 : [
//                                                     BoxShadow(
//                                                       color: colorScheme.primary.withOpacity(0.22),
//                                                       blurRadius: 12,
//                                                       offset: const Offset(0, 6),
//                                                     )
//                                                   ],
//                                           ),
//                                           child: Center(
//                                             child: AnimatedSwitcher(
//                                               duration: const Duration(milliseconds: 200),
//                                               child: loading
//                                                   ? const SizedBox(key: ValueKey('loading2'), width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                                                   : Row(
//                                                       key: const ValueKey('label2'),
//                                                       mainAxisSize: MainAxisSize.min,
//                                                       children: [
//                                                         Icon(Icons.save, color: Colors.white),
//                                                         const SizedBox(width: 10),
//                                                         Text('Save Expense', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//                                                       ],
//                                                     ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 18),

//                   // Expense list below the form
//                   Obx(() {
//                     final list = controller.expenseList;
//                     if (list.isEmpty) {
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Center(child: Text('No expenses recorded', style: Theme.of(context).textTheme.bodyMedium)),
//                         ),
//                       );
//                     }

//                     return ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: list.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 8),
//                       itemBuilder: (_, i) {
//                         final exp = list[i];
//                         return Card(
//                           elevation: 2,
//                           child: ListTile(
//                             title: Text(exp.title),
//                             subtitle: Text('${exp.category} • ${exp.date.toString().split(' ')[0]}'),
//                             trailing: Text('₹${exp.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                             onLongPress: () {
//                               Get.defaultDialog(
//                                 title: 'Delete',
//                                 middleText: 'Delete this expense?',
//                                 onConfirm: () {
//                                   controller.deleteExpense(exp.id);
//                                   Get.back();
//                                 },
//                                 onCancel: () {},
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:intl/intl.dart';

class MilkLogColors {
  static const primary = Color(0xFF1E88E5);
  static const accent = Color(0xFF64B5F6);
  static const creamBg = Color(0xFFF5F7FA);
  static const darkBg = Color(0xFF0E1A24);
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



class AExpense extends StatelessWidget {
  AExpense({super.key});

  final controller = Get.put(AExpenseController());

  final isLoading = false.obs;

  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final RxString _category = ''.obs;
  final Rx<DateTime> _date = DateTime.now().obs;

  void _clear() {
    _titleCtrl.clear();
    _amountCtrl.clear();
    _category.value = '';
    _date.value = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MilkLogColors.creamBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MilkLogColors.creamBg,
        centerTitle: true,
        title: const Text(
          'Expense',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ===== HEADER =====
              const Text(
                "Add Expense",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                "Track your daily expenses",
                style: TextStyle(color: Colors.grey.shade600),
              ),

              const SizedBox(height: 18),

              /// ===== FORM CARD =====
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      /// TITLE
                      _inputField(
                        controller: _titleCtrl,
                        label: "Title",
                        icon: Icons.note_add,
                      ),

                      const SizedBox(height: 12),

                      /// AMOUNT
                      _inputField(
                        controller: _amountCtrl,
                        label: "Amount",
                        icon: Icons.currency_rupee,
                        keyboard: TextInputType.number,
                      ),

                      const SizedBox(height: 12),

                      /// CATEGORY
                      Obx(() => DropdownButtonFormField<String>(
                            value: _category.value.isEmpty
                                ? null
                                : _category.value,
                            decoration: _decoration("Category"),
                            items: const [
                              'Feed',
                              'Medicine',
                              'Salary',
                              'Transport',
                              'Repair',
                              'Other',
                            ]
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (v) => _category.value = v ?? '',
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Select category' : null,
                          )),

                      const SizedBox(height: 12),

                      /// DATE
                      Obx(() {
                        final dt = _date.value;
                        return InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: dt,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2035),
                            );
                            if (picked != null) _date.value = picked;
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: InputDecorator(
                            decoration: _decoration("Date"),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat('dd MMM yyyy').format(dt)),
                                const Icon(Icons.calendar_today, size: 18),
                              ],
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 16),

                      /// BUTTONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _clear,
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text("Clear"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Obx(() {
                              final loading = isLoading.value;
                              return GestureDetector(
                                onTap: loading
                                    ? null
                                    : () async {
                                        if (!(_formKey.currentState
                                                ?.validate() ??
                                            false)) return;

                                        isLoading.value = true;

                                        try {
                                          controller.title.value = _titleCtrl.text.trim();
                                          controller.amount.value = _amountCtrl.text.trim();
                                          controller.category.value = _category.value;
                                          controller.date.value = _date.value;

                                          controller.saveExpense();

                                          Get.snackbar(
                                              "Success", "Expense added");
                                          _clear();
                                        } finally {
                                          isLoading.value = false;
                                        }
                                      },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        MilkLogColors.primary,
                                        MilkLogColors.accent
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: loading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        : const Text(
                                            "Save Expense",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 26),

              /// ===== HISTORY =====
              const Text(
                "Expense History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              Obx(() {
                final list = controller.expenseList;

                if (list.isEmpty) {
                  return _emptyCard("No expenses recorded");
                }

                /// SORT DESC
                final sorted = [...list]
                  ..sort((a, b) => b.date.compareTo(a.date));

                /// GROUP BY MONTH
                final Map<DateTime, List<dynamic>> grouped = {};
                for (var e in sorted) {
                  final key = DateTime(e.date.year, e.date.month);
                  grouped.putIfAbsent(key, () => []).add(e);
                }

                final months = grouped.keys.toList()
                  ..sort((a, b) => b.compareTo(a));

                return Column(
                  children: months.map((month) {
                    final data = grouped[month]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            DateFormat('MMMM yyyy').format(month),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        /// LIST
                        ...data.map((exp) {
                          return Dismissible(
                            key: ValueKey(exp.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.delete,
                                  color: Colors.white),
                            ),
                            onDismissed: (_) {
                              controller.deleteExpense(exp.id);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.money_off,
                                        color: Colors.red.shade600),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          exp.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${exp.category} • ${DateFormat('dd MMM').format(exp.date)}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${exp.amount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// ===== COMMON WIDGETS =====

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboard,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: _decoration(label, icon: icon),
      validator: (v) =>
          v == null || v.isEmpty ? 'Required field' : null,
    );
  }

  InputDecoration _decoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon:
          icon != null ? Icon(icon, color: MilkLogColors.primary) : null,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _emptyCard(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(text)),
    );
  }
}




// class AExpense extends StatelessWidget {
//   const AExpense({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AExpenseController());
//     final formKey = GlobalKey<FormState>();

//     return Scaffold(
//       backgroundColor: MilkLogColors.creamBg,

//       /// APPBAR (same style as homepage)
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: MilkLogColors.creamBg,
//         centerTitle: true,
//         title: const Text(
//           "Expenses",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// ================= ADD EXPENSE =================
//               Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(22),
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white,
//                       MilkLogColors.primary.withOpacity(0.05),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 18,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// HEADER
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: MilkLogColors.primary.withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.add,
//                               color: MilkLogColors.primary,
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           const Text(
//                             "Add Expense",
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 16),

//                       /// TITLE
//                       TextFormField(
//                         decoration: _inputDecoration("Title"),
//                         onChanged: (v) => controller.title.value = v,
//                         validator: (v) =>
//                             v == null || v.isEmpty ? "Enter title" : null,
//                       ),

//                       const SizedBox(height: 12),

//                       /// AMOUNT
//                       TextFormField(
//                         keyboardType:
//                             const TextInputType.numberWithOptions(decimal: true),
//                         decoration: _inputDecoration("Amount"),
//                         onChanged: (v) => controller.amount.value = v,
//                         validator: (v) {
//                           if (v == null || v.isEmpty) return "Enter amount";
//                           final n = double.tryParse(v);
//                           if (n == null || n <= 0) return "Invalid amount";
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 12),

//                       /// CATEGORY
//                       Obx(() => DropdownButtonFormField<String>(
//                             value: controller.category.value.isEmpty
//                                 ? null
//                                 : controller.category.value,
//                             decoration: _inputDecoration("Category"),
//                             items: const [
//                               'Feed',
//                               'Medicine',
//                               'Salary',
//                               'Transport',
//                               'Repair',
//                               'Other',
//                             ]
//                                 .map((e) => DropdownMenuItem(
//                                       value: e,
//                                       child: Text(e),
//                                     ))
//                                 .toList(),
//                             onChanged: (v) =>
//                                 controller.category.value = v ?? '',
//                             validator: (v) =>
//                                 v == null ? "Select category" : null,
//                           )),

//                       const SizedBox(height: 12),

//                       /// DATE
//                       Obx(() {
//                         final date = controller.date.value;
//                         return InkWell(
//                           onTap: () async {
//                             final picked = await showDatePicker(
//                               context: context,
//                               initialDate: date,
//                               firstDate: DateTime(2020),
//                               lastDate: DateTime(2035),
//                             );
//                             if (picked != null) {
//                               controller.date.value = picked;
//                             }
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 14, vertical: 16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             child: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   DateFormat('dd MMM yyyy').format(date),
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const Icon(Icons.calendar_today, size: 18),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),

//                       const SizedBox(height: 16),

//                       /// BUTTONS
//                       Row(
//                         children: [
//                           // Expanded(
//                           //   child: OutlinedButton(
//                           //     onPressed: () {
//                           //       controller.title.value = '';
//                           //       controller.amount.value = '';
//                           //       controller.category.value = '';
//                           //       controller.date.value = DateTime.now();
//                           //     },
//                           //     style: OutlinedButton.styleFrom(
//                           //       shape: RoundedRectangleBorder(
//                           //         borderRadius: BorderRadius.circular(14),
//                           //       ),
//                           //     ),
//                           //     child: const Text("Clear"),
//                           //   ),
//                           // ),
//                           // const SizedBox(width: 12),
//                           Expanded(
//                             child: Obx(() {
//                               final loading = controller.isLoading.value;
//                               return ElevatedButton(
//                                 onPressed: loading
//                                     ? null
//                                     : () {
//                                         if (formKey.currentState?.validate() ??
//                                             false) {
//                                           controller.saveExpense();
//                                           Get.snackbar(
//                                             "Success",
//                                             "Expense added",
//                                           );
//                                         }
//                                       },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: MilkLogColors.primary.withOpacity(0.6),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(14),
//                                   ),
//                                 ),
//                                 child: loading
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const Text("Save"),
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 28),

//               /// ================= HISTORY =================
//               const Text(
//                 "Expense History",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 16),

//               Obx(() {
//                 final list = controller.expenseList;

//                 if (list.isEmpty) {
//                   return _emptyCard();
//                 }

//                 /// SORT DESC
//                 final sorted = [...list]
//                   ..sort((a, b) => b.date.compareTo(a.date));

//                 /// GROUP BY MONTH
//                 final Map<DateTime, List<dynamic>> grouped = {};
//                 for (var e in sorted) {
//                   final key = DateTime(e.date.year, e.date.month);
//                   grouped.putIfAbsent(key, () => []).add(e);
//                 }

//                 final months = grouped.keys.toList()
//                   ..sort((a, b) => b.compareTo(a));

//                 return Column(
//                   children: months.map((month) {
//                     final expenses = grouped[month]!;

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /// MONTH TITLE
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: Text(
//                             DateFormat('MMMM yyyy').format(month),
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),

//                         /// CARD GROUP
//                         _Card(
//                           child: Column(
//                             children: expenses.map((e) {
//                               return Dismissible(
//                                 key: Key(e.id.toString()),
//                                 direction: DismissDirection.endToStart,

//                                 /// DELETE BG
//                                 background: Container(
//                                   alignment: Alignment.centerRight,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20),
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.circular(14),
//                                   ),
//                                   child: const Icon(Icons.delete,
//                                       color: Colors.white),
//                                 ),

//                                 /// CONFIRM
//                                 confirmDismiss: (_) async {
//                                   return await Get.dialog(
//                                     Dialog(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(18),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(18),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             const Icon(Icons.delete,
//                                                 color: Colors.red, size: 30),
//                                             const SizedBox(height: 10),
//                                             const Text(
//                                               "Delete Expense?",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             Text(
//                                               "This action cannot be undone",
//                                               style: TextStyle(
//                                                   color:
//                                                       Colors.grey.shade600),
//                                             ),
//                                             const SizedBox(height: 18),

//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: OutlinedButton(
//                                                     onPressed: () =>
//                                                         Get.back(result: false),
//                                                     child:
//                                                         const Text("Cancel"),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 10),
//                                                 Expanded(
//                                                   child: ElevatedButton(
//                                                     style: ElevatedButton
//                                                         .styleFrom(
//                                                       backgroundColor:
//                                                           Colors.red,
//                                                     ),
//                                                     onPressed: () =>
//                                                         Get.back(result: true),
//                                                     child:
//                                                         const Text("Delete"),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },

//                                 onDismissed: (_) {
//                                   controller.deleteExpense(e.id);
//                                 },

//                                 /// ITEM UI
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                           color: MilkLogColors.primary
//                                               .withOpacity(0.1),
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: const Icon(Icons.money_off,
//                                             color: MilkLogColors.primary,
//                                             size: 18),
//                                       ),
//                                       const SizedBox(width: 12),

//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               e.title,
//                                               style: const TextStyle(
//                                                   fontWeight:
//                                                       FontWeight.w600),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               "${e.category} • ${DateFormat('dd MMM').format(e.date)}",
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 color:
//                                                     Colors.grey.shade600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),

//                                       Text(
//                                         "₹${e.amount.toStringAsFixed(2)}",
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),

//                         const SizedBox(height: 16),
//                       ],
//                     );
//                   }).toList(),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// INPUT STYLE
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide.none,
//       ),
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//     );
//   }

//   /// EMPTY STATE
//   Widget _emptyCard() {
//     return _Card(
//       child: Center(
//         child: Text(
//           "No expenses yet",
//           style: TextStyle(color: Colors.grey.shade600),
//         ),
//       ),
//     );
//   }
// }
