import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';

class ADeliveredService extends GetxService{
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');
  final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');

  bool isTodayMarked(DateTime date) {
    final marked = deliveredBox.values.where((e) => e.date.day == date.day &&  e.date.month == date.month && e.date.year == date.year).toList();
    if (marked.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  
  getCustomerList(){
    final customers = customerBox.values.toList();
    return customers;
  }

  saveCustomer(Delivered delivered){
    // deliveredBox. clear();
    deliveredBox.put(delivered.id, delivered);
    print(deliveredBox.values.toList());
  }
}