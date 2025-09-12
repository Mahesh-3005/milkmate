import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.addcustomer.dart';

class AddCustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddCustomerController>(()=> AddCustomerController());
  } 
}