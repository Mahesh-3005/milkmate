import 'package:get/get.dart';
import 'package:milklog/getx/services/s.acustomer.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';

class ACustomerController extends GetxService {
  final service = ACustomerService();
  List<Customer> customerList = [];

  @override
  void onInit() async {
    await getCustomer();
    super.onInit();
  }

  getCustomer() async {
    Admin? admin = service.getAdminInfo();
    if (admin != null) {
      customerList = service.getCustomerList();
    } else {
      
    }
    // final pref = await SharedPreferences.getInstance();
    // var id = pref.getString('id');
    // if (id != null) {
    //   customerList.value = await sacustomer.getCustomerList(id);
    // }
  }
}
