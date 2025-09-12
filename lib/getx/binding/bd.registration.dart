import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.registration.dart';

class RegistrationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(()=> RegistrationController());
  }
}