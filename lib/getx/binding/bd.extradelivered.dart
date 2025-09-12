import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.extradelivered.dart';

class ExtraDeliveredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut <ExtraDeliveredController>(()=>ExtraDeliveredController());
  }
}