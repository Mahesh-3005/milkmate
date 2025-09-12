import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.acustomer.dart';

class ACustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ACustomerController>(()=> ACustomerController());
  } 
}