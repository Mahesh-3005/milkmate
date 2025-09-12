import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';

class CustomerHomeService extends GetxService {
  final customerBox = Hive.box<Customer>('Customer');

  Customer getCustomerDetails()  {
    return customerBox.values.first;
  }
}
