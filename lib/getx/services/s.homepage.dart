import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';

class HomePageService extends GetxService {
  final adminBox = Hive.box<Admin>('Admin');
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');
  final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
  final Box<Edelivered> edeliveredBox = Hive.box<Edelivered>('Edelivered');
  
  Admin getAdminInfo() {
    return adminBox.values.first;
  }

  getCustomerCount(){
    return customerBox.values.toList().length;
  }

  getDeliveredCount(){
  final today = DateTime.now();

  return deliveredBox.values.where((e) =>
    e.date.year == today.year &&
    e.date.month == today.month &&
    e.date.day == today.day
  ).length;
  }

}
