import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.aexpense.dart';

class AExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AExpenseController>(()=> AExpenseController());
  }
}