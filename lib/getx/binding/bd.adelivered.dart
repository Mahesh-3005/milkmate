import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.adelivered.dart';

class ADeliveredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ADeliveredController>(()=> ADeliveredController());
  }
}