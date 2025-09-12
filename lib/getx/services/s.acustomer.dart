import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';

class ACustomerService extends GetxService {
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

  List<Customer> getCustomerList(){
    final customers = customerBox.values.toList();
    return customers;
  }


  // final supabase = Supabase.instance.client;

  // Future<List<Map<String,dynamic>>> getCustomerList(String id) async {
  //   try {
  //     final response = await supabase.from('Customer').select().eq('admin_id', id).eq('is_deleted', false);
  //   return response;
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }
}