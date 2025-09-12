import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.customerhome.dart';

class CustomerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerHomeController>(()=>CustomerHomeController());
  } 
}