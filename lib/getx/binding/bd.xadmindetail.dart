import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.xadminDetail.dart';

class XAdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<XAdminDetailController>(() => XAdminDetailController());
  }
} 