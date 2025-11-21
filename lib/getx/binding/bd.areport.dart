import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.areport.dart';

class AReportBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AReportController>(()=> AReportController());
  }
}