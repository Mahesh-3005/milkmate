import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';

class DCustomerProfileService extends GetxService {
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');

 getCustomerDetails(String id) {
  final customer =   customerBox.values.firstWhere((c)=> c.id == id);
  return customer;
 }

   isPhoneExist(String phone,String customerId){
    final exist = customerBox.values.where((c)=> c.phone == phone && c.id != customerId).toList();
    if (exist.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  updateCustomer(Customer customer){
    customerBox.put(customer.id, customer);
  }
  // final supabase = Supabase.instance.client;

  // Future<void> updateCustomerDetail(Map data,String id)async{
  //   try {
  //     final response = await supabase.from('Customer').update(data).eq('id', id).eq('is_deleted', false);
  //   } catch (e) {
  //     print('Error:$e');
  //   }
     
  // }
}