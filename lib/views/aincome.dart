import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../getx/controller/ct.aincome.dart';

// class AIncome extends StatelessWidget {
//   AIncome({super.key});

//   final controller = Get.put(AIncomeController());
//   final isLoading = false.obs;

//   final _formKey = GlobalKey<FormState>();
//   final _titleCtrl = TextEditingController();
//   final _amountCtrl = TextEditingController();
//   final RxString _category = ''.obs;
//   final Rx<DateTime> _date = DateTime.now().obs;

//   InputDecoration _dec({required String label, IconData? icon, String? hint, Color? primaryColor}) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       prefixIcon: icon != null ? Icon(icon, color: primaryColor) : null,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//     );
//   }

//   void _clear() {
//     _titleCtrl.clear();
//     _amountCtrl.clear();
//     _category.value = '';
//     _date.value = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         title: const Text('Income'),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: colorScheme.onBackground,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 760),
//               child: Column(
//                 children: [
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                     elevation: 6,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.12), shape: BoxShape.circle),
//                                   padding: const EdgeInsets.all(12),
//                                   child: Icon(Icons.trending_up, color: colorScheme.primary),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Add Income', style: Theme.of(context).textTheme.titleLarge),
//                                     const SizedBox(height: 4),
//                                     Text('Record money received', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
//                                   ],
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 16),

//                             // Title
//                             TextFormField(
//                               controller: _titleCtrl,
//                               decoration: _dec(label: 'Title', icon: Icons.note_add, hint: 'E.g., Product sale'),
//                               validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter title' : null,
//                             ),

//                             const SizedBox(height: 12),

//                             // Amount with rupee prefix
//                             TextFormField(
//                               controller: _amountCtrl,
//                               keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                               decoration: _dec(label: 'Amount', icon: Icons.currency_rupee, hint: '0.00').copyWith(
//                                 // prefixText: '₹ ',
//                                  prefixStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w600)),
//                               validator: (v) {
//                                 if (v == null || v.trim().isEmpty) return 'Enter amount';
//                                 final n = double.tryParse(v);
//                                 if (n == null) return 'Invalid number';
//                                 if (n <= 0) return 'Amount must be > 0';
//                                 return null;
//                               },
//                             ),

//                             const SizedBox(height: 12),

//                             // Category
//                             Obx(() => DropdownButtonFormField<String>(
//                                   value: _category.value.isEmpty ? null : _category.value,
//                                   decoration: _dec(label: 'Category', icon: Icons.category),
//                                   items: const [
//                                     'Cow Dung Sale',
//                                     'Old Cattle Sale',
//                                     'Farm Product Sale'
//                                     'Other',
//                                   ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                                   onChanged: (v) => _category.value = v ?? '',
//                                   validator: (v) => (v == null || v.isEmpty) ? 'Select category' : null,
//                                 )),

//                             const SizedBox(height: 12),

//                             // Date
//                             Obx(() {
//                               final dt = _date.value;
//                               final label = DateFormat('dd/MM/yyyy').format(dt);
//                               return InkWell(
//                                 onTap: () async {
//                                   final picked = await showDatePicker(
//                                     context: context,
//                                     initialDate: dt,
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime(2100),
//                                   );
//                                   if (picked != null) _date.value = picked;
//                                 },
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: InputDecorator(
//                                   decoration: _dec(label: 'Date', icon: Icons.calendar_today),
//                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), const Icon(Icons.keyboard_arrow_down)]),
//                                 ),
//                               );
//                             }),

//                             const SizedBox(height: 18),

//                             // Actions
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: OutlinedButton(
//                                     style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
//                                     onPressed: _clear,
//                                     child: const Text('Clear'),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Obx(() {
//                                     final loading = isLoading.value;
//                                     return GestureDetector(
//                                       onTap: loading
//                                           ? null
//                                           : () async {
//                                               if (!(_formKey.currentState?.validate() ?? false)) return;
//                                               isLoading.value = true;
//                                               try {
//                                                 final title = _titleCtrl.text.trim();
//                                                 final amount = double.parse(_amountCtrl.text.trim());
//                                                 final date = _date.value;
//                                                 final category = _category.value;

//                                                 controller.addIncome(title, amount, date, category);

//                                                 Get.snackbar('Success', 'Income saved');
//                                                 _clear();
//                                               } catch (e) {
//                                                 Get.snackbar('Error', 'Failed to save');
//                                               } finally {
//                                                 isLoading.value = false;
//                                               }
//                                             },
//                                       child: AnimatedContainer(
//                                         duration: const Duration(milliseconds: 200),
//                                         height: 52,
//                                         decoration: BoxDecoration(
//                                           gradient: loading ? null : LinearGradient(colors: [colorScheme.primary, colorScheme.primaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight),
//                                           color: loading ? Colors.grey.shade400 : null,
//                                           borderRadius: BorderRadius.circular(12),
//                                           boxShadow: loading
//                                               ? []
//                                               : [BoxShadow(color: colorScheme.primary.withOpacity(0.22), blurRadius: 12, offset: const Offset(0, 6))],
//                                         ),
//                                         child: Center(
//                                           child: AnimatedSwitcher(
//                                             duration: const Duration(milliseconds: 200),
//                                             child: loading
//                                                 ? const SizedBox(key: ValueKey('l'), width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                                                 : Row(key: const ValueKey('t'), mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.save, color: Colors.white), const SizedBox(width: 10), const Text('Save Income', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))]),
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

//                   // Income list
//                   Obx(() {
//                     final list = controller.incomeList;
//                     if (list.isEmpty) {
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Center(child: Text('No income recorded', style: Theme.of(context).textTheme.bodyMedium)),
//                         ),
//                       );
//                     }

//                     return ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: list.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 8),
//                       itemBuilder: (_, i) {
//                         final inc = list[i];
//                         return Card(
//                           elevation: 2,
//                           child: ListTile(
//                             title: Text(inc.title),
//                             subtitle: Text('${inc.category} • ${DateFormat('dd/MM/yyyy').format(inc.date)}'),
//                             trailing: Text('₹${inc.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                             onLongPress: () {
//                               // delete
//                               Get.defaultDialog(
//                                 title: 'Delete',
//                                 middleText: 'Delete this income?',
//                                 onConfirm: () {
//                                   controller.deleteIncome(inc.id);
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


class MilkLogColors {
  static const primary = Color(0xFF1E88E5);
  static const accent = Color(0xFF64B5F6);
  static const creamBg = Color(0xFFF5F7FA);
  static const darkBg = Color(0xFF0E1A24);
}



class AIncome extends StatelessWidget {
  AIncome({super.key});

  final controller = Get.put(AIncomeController());

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
          'Income',
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
                "Add Income",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                "Track money received",
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
                              'Cow Dung Sale',
                              'Old Cattle Sale',
                              'Farm Product Sale',
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
                                          controller.addIncome(
                                            _titleCtrl.text.trim(),
                                            double.parse(
                                                _amountCtrl.text.trim()),
                                            _date.value,
                                            _category.value,
                                          );

                                          Get.snackbar(
                                              "Success", "Income added");
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
                                            "Save Income",
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
                "Income History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              Obx(() {
                final list = controller.incomeList;

                if (list.isEmpty) {
                  return _emptyCard("No income recorded");
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
                        ...data.map((inc) {
                          return Dismissible(
                            key: ValueKey(inc.id),
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
                              controller.deleteIncome(inc.id);
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
                                      color: Colors.green.shade50,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.trending_up,
                                        color: Colors.green.shade600),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          inc.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${inc.category} • ${DateFormat('dd MMM').format(inc.date)}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${inc.amount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green,
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