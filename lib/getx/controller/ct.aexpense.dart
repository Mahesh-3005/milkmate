import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/getx/services/s.aexpense.dart';
import 'package:milklog/hive_model/expense.dart';
import 'package:uuid/uuid.dart';

class AExpenseController extends GetxController {
final title = ''.obs;
  final amount = ''.obs;
  final category = ''.obs;
  final date = DateTime.now().obs;
  // final notes = ''.obs;
  final service = AExpenseService();

  final isLoading = false.obs;
  final expenseBox = Hive.box<ExpenseModel>('Expense');

  RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  void loadExpenses() {
    expenseList.value = expenseBox.values.where((e) => !e.isDeleted).toList();
  }

  Future<void> saveExpense() async {
    isLoading.value = true;
    final admin = service.getAdminInfo();

    final expense = ExpenseModel(
      id: const Uuid().v4(),
      title: title.value,
      amount: double.tryParse(amount.value) ?? 0.0,
      date: date.value,
      category: category.value,
      adminId: admin?.id ?? '',
      isDeleted: false,
      createdAt: DateTime.now(),
      isSynced: false,
    );

    await expenseBox.put(expense.id, expense);

    // reload list and reset fields
    loadExpenses();
    title.value = '';
    amount.value = '';
    category.value = '';
    date.value = DateTime.now();

    isLoading.value = false;
  }

  void deleteExpense(String id) {
    final data = expenseBox.get(id);
    if (data != null) {
      data.isDeleted = true;
      data.isSynced = false;
      data.save();
    }
    loadExpenses();
  }

  void clearForm() {
  title.value = '';
  amount.value = '';
  category.value = '';
  date.value = DateTime.now();
}
}

