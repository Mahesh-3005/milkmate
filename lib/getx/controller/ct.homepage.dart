import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/getx/services/s.homepage.dart';
import 'package:milklog/getx/services/s.sync.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:milklog/hive_model/expense.dart';
import 'package:milklog/hive_model/income.dart';
import 'package:milklog/hive_model/organization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  final RxString name = ''.obs;
  final RxInt customerCount = 0.obs;
  final RxInt delivered = 0.obs;
  final HomePageService service = HomePageService();
  final SyncService syncService = SyncService();

  @override
  void onInit() {
    getRequiredData();
    super.onInit();
  }

  getRequiredData() {
    Admin admin = service.getAdminInfo();
    name.value = '${admin.firstName} ${admin.lastName}';
    customerCount.value = service.getCustomerCount();
    delivered.value = service.getDeliveredCount();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sync() async {
    await syncService.syncAdmin();
    await syncService.syncOrganization();
    await syncService.syncCustomer();
    await syncService.syncDelivered();
    await syncService.syncEdelivered();
    await syncService.syncExpense();
    await syncService.syncIncome();
    Get.snackbar('Success', 'Sync successfull');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await clearLocalData(); // Hive local data clear
    Get.offAllNamed('/login');
  }

  Future<void> clearLocalData() async {
    await Hive.box<Customer>('Customer').clear();
    await Hive.box<Organization>('Organization').clear();
    await Hive.box<Admin>('Admin').clear();
    await Hive.box<Delivered>('Delivered').clear();
    await Hive.box<Edelivered>('Edelivered').clear();
    await Hive.box<ExpenseModel>('Expense').clear();
    await Hive.box<IncomeModel>('Income').clear();                
  }
}
