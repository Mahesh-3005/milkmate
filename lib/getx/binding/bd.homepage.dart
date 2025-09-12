import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.homepage.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(()=>HomePageController());
  }
}