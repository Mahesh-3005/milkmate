import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/controller/ct.aexpense.dart';

class AExpense extends StatelessWidget {
  const AExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AExpenseController());
    final colorScheme = Theme.of(context).colorScheme;
    final _formKey = GlobalKey<FormState>();

    InputDecoration _fieldDecoration({required String label, IconData? icon, String? hint}) {
      return InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: colorScheme.primary) : null,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Add Expense'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onBackground,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorScheme.primary.withOpacity(0.12),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Icon(Icons.receipt_long, color: colorScheme.primary),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Add Expense', style: Theme.of(context).textTheme.titleLarge),
                                    const SizedBox(height: 4),
                                    Text('Record a new expense quickly', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // Title field
                            TextFormField(
                              initialValue: controller.title.value,
                              decoration: _fieldDecoration(label: 'Title', icon: Icons.note_add, hint: 'Feed, Repair, Salary...'),
                              onChanged: (v) => controller.title.value = v,
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
                            ),
                            const SizedBox(height: 14),

                            // Amount (with rupee prefix)
                            TextFormField(
                              initialValue: controller.amount.value,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: _fieldDecoration(label: 'Amount', icon: Icons.currency_rupee, hint: '0.00').copyWith(
                                prefixStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w600),
                              ),
                              onChanged: (v) => controller.amount.value = v,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Enter amount';
                                final n = double.tryParse(v);
                                if (n == null) return 'Invalid number';
                                if (n <= 0) return 'Amount must be > 0';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            Obx(() => DropdownButtonFormField<String>(
                                  value: controller.category.value.isEmpty ? null : controller.category.value,
                                  decoration: _fieldDecoration(label: 'Category', icon: Icons.category),
                                  items: const [
                                    'Feed',
                                    'Medicine',
                                    'Salary',
                                    'Transport',
                                    'Repair',
                                    'Other',
                                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  onChanged: (v) => controller.category.value = v ?? '',
                                  validator: (v) => (v == null || v.isEmpty) ? 'Select category' : null,
                                )),
                            const SizedBox(height: 14),

                            // Date picker
                            Obx(() {
                              final dt = controller.date.value;
                              final label = '${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}';
                              return InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: dt,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2035),
                                  );
                                  if (picked != null) controller.date.value = picked;
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: InputDecorator(
                                  decoration: _fieldDecoration(label: 'Date', icon: Icons.calendar_today),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(label, style: Theme.of(context).textTheme.bodyLarge),
                                      const Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 14),

                            // Actions
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () {
                                      controller.title.value = '';
                                      controller.amount.value = '';
                                      controller.category.value = '';
                                      controller.date.value = DateTime.now();
                                    },
                                    child: const Text('Clear'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Obx(() {
                                    final loading = controller.isLoading.value;
                                    return SizedBox(
                                      height: 52,
                                      child: GestureDetector(
                                        onTap: loading
                                            ? null
                                            : () {
                                                if (_formKey.currentState?.validate() ?? false) {
                                                  controller.saveExpense();
                                                  Get.snackbar("Success", "Expense added successfully!");

                                                }
                                              },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          decoration: BoxDecoration(
                                            gradient: loading
                                                ? null
                                                : LinearGradient(colors: [colorScheme.primary, colorScheme.primaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                            color: loading ? Colors.grey.shade400 : null,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: loading
                                                ? []
                                                : [
                                                    BoxShadow(
                                                      color: colorScheme.primary.withOpacity(0.22),
                                                      blurRadius: 12,
                                                      offset: const Offset(0, 6),
                                                    )
                                                  ],
                                          ),
                                          child: Center(
                                            child: AnimatedSwitcher(
                                              duration: const Duration(milliseconds: 200),
                                              child: loading
                                                  ? const SizedBox(key: ValueKey('loading2'), width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                                  : Row(
                                                      key: const ValueKey('label2'),
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(Icons.save, color: Colors.white),
                                                        const SizedBox(width: 10),
                                                        Text('Save Expense', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                                      ],
                                                    ),
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
                  ),

                  const SizedBox(height: 18),

                  // Expense list below the form
                  Obx(() {
                    final list = controller.expenseList;
                    if (list.isEmpty) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(child: Text('No expenses recorded', style: Theme.of(context).textTheme.bodyMedium)),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final exp = list[i];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(exp.title),
                            subtitle: Text('${exp.category} • ${exp.date.toString().split(' ')[0]}'),
                            trailing: Text('₹${exp.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            onLongPress: () {
                              Get.defaultDialog(
                                title: 'Delete',
                                middleText: 'Delete this expense?',
                                onConfirm: () {
                                  controller.deleteExpense(exp.id);
                                  Get.back();
                                },
                                onCancel: () {},
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}