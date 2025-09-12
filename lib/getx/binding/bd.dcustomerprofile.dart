import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.dcustomerprofile.dart';

class DCustomerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DCustomerProfileController>(()=>DCustomerProfileController());
  }
}