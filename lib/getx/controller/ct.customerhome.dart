import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/getx/services/s.customerhome.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:milklog/hive_model/organization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHomeController extends GetxController {
  RxString name = ''.obs;
  final service = CustomerHomeService();

  @override
  void onInit() {
    getFirstPageData();
    super.onInit();
  }

  getFirstPageData() {
      Customer customer =  service.getCustomerDetails();
      name.value = "${customer.firstName} ${customer.lastName}";
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await clearLocalData();  // Hive local data clear
    Get.offAllNamed('/login');
  }

  Future<void> clearLocalData() async {
  await Hive.box<Customer>('Customer').clear();
  await Hive.box<Organization>('Organization').clear();
  await Hive.box<Admin>('Admin').clear();
  await Hive.box<Delivered>('Delivered').clear();
  await Hive.box<Edelivered>('Edelivered').clear();
}
}
