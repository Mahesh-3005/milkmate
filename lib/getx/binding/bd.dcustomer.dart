import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.dcustomer.dart';

class DCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DCustomerController>(()=>DCustomerController());
  } 
}