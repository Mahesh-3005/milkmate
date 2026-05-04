import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/getx/services/s.aincome.dart';
import 'package:milklog/hive_model/income.dart';
import 'package:uuid/uuid.dart';

class AIncomeController extends GetxController {
  final box = Hive.box<IncomeModel>('Income');
  final service = AIncomeService();

  RxList<IncomeModel> incomeList = <IncomeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadIncome();
  }

  void loadIncome() {
    incomeList.value = box.values.where((e) => !e.isDeleted).toList();
  }

  void addIncome(String title, double amount, DateTime date, String category) {
    final id = const Uuid().v4();
    final admin = service.getAdminInfo();

    final income = IncomeModel(
      id: id,
      title: title,
      amount: amount,
      date: date,
      category: category,
      adminId: admin?.id ?? '',
      createdAt: DateTime.now(),
      isDeleted: false,
      isSynced: false,
    );

    box.put(id, income);
    loadIncome();
  }

  void deleteIncome(String id) {
    final data = box.get(id);
    if (data != null) {
      data.isDeleted = true;
      data.isSynced = false;
      data.save();
    }
    loadIncome();
  }
} 
