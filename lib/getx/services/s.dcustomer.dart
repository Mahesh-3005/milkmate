import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';

class DCustomerService extends GetxService {
final Box<Customer> customerBox = Hive.box<Customer>('Customer');

 getCustomerDetails() {
  final customer = customerBox.values.first;
  return customer;
 }

 getCustomerDetailsById(String id) {
  final customer = customerBox.values.firstWhere((e)=> e.id == id);
  return customer;
 }
}