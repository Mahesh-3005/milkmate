import 'package:get/get.dart';
import 'package:milklog/getx/services/s.dcustomer.dart';
import 'package:milklog/hive_model/customer.dart';

class DCustomerController extends GetxController {
  RxString firstname = ''.obs;
  RxString middlename = ''.obs;
  RxString lastname = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxString organizationname = ''.obs;
  RxDouble rate = 0.0.obs;
  RxDouble quantity = 0.0.obs;
  RxString milktype = ''.obs;
  RxString deliverytime = ''.obs;
  final service = DCustomerService();
  final args = Get.arguments;
  RxBool isCustomer = false.obs;

  @override
  void onInit() {
    getinitialdetails();
    super.onInit();
  }

  getinitialdetails() {
    if (args['role'] == 'Customer') {
      isCustomer.value = true;
    }
    if (args['id'] != null) {
    final id = args['id'];
    Customer customer = service.getCustomerDetailsById(id);
    firstname.value = customer.firstName;
    middlename.value = customer.middleName;
    lastname.value = customer.lastName;
    phone.value = customer.phone;
    address.value = customer.address;
    quantity.value = customer.quantity;
    rate.value = customer.rate;
    milktype.value = customer.milkType;
    deliverytime.value = customer.deliveryTime;
    } else {
    Customer customer = service.getCustomerDetails();
    firstname.value = customer.firstName;
    middlename.value = customer.middleName;
    lastname.value = customer.lastName;
    phone.value = customer.phone;
    address.value = customer.address;
    quantity.value = customer.quantity;
    rate.value = customer.rate;
    milktype.value = customer.milkType;
    deliverytime.value = customer.deliveryTime;
    }
  }
}
