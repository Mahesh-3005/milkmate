import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';

class DeliveryStatusService extends GetxService {

  final customerBox = Hive.box<Customer>('Customer');
  final deliveredBox = Hive.box<Delivered>('Delivered');

  Customer getCustomerDetails()  {
    return customerBox.values.first;
  }

  getDeliveredDates(){
    final dates = deliveredBox.values.toList();
    return dates.map((e) => DateTime.parse(e.date.toString()))
    .toList();
  }
  // final supabase = Supabase.instance.client;

  // Future<List<DateTime>> getDeliveredDates(String id) async {
  //   try {
  //     final response = await supabase.from('Delivered').select('date').eq('customerid', id);
  //     return response.map((e) => DateTime.parse(e['date'].toString()))
  //   .toList();
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }
}