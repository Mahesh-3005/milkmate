import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';

class AReportService extends GetxService{
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');


  List<Customer> getCustomerList(){
    final customers = customerBox.values.toList();
    return customers;
  }
}