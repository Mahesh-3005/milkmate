import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.login.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(()=>LoginController());
  }
}