import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.deliverystatus.dart';

class DeliveryStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>DeliveryStatusController());
  }
  
}