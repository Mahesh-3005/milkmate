import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/edelivered.dart';

class ExtraDeliveredService extends GetxService {
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');
  final Box<Edelivered> edeliveredBox = Hive.box<Edelivered>('Edelivered');

  getCustomerList() {
    final customers = customerBox.values.toList();
    return customers;
  }

  getCustomer(String id) {
    final customer = customerBox.values.singleWhere((e) => e.id == id);
    return customer;
  }

  saveExtraDeliveries(Edelivered delivery) {
    // edeliveredBox.clear();
    edeliveredBox.put(delivery.id, delivery);
  }
}
