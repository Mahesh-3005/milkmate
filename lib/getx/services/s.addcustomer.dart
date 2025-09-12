import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';

class AddCustomerService extends GetxService {
  final Box<Admin> adminBox = Hive.box<Admin>('Admin');
  // final Box<Organization> organizationBox = Hive.box<Organization>('Organization');
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');

  Admin? getAdminInfo() {
    if (adminBox.isNotEmpty) {
      return adminBox.values.first;
    } else {
      return null;
    }
  }

  saveCustomer(Customer customer){
    customerBox.put(customer.id, customer);
    print(customerBox.values.toList());
  }
  
  isPhoneExist(String phone){
    final exist = customerBox.values.where((c)=> c.phone == phone).toList();
    if (exist.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }
}