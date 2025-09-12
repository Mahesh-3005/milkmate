import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.profile.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(()=>ProfileController());
  }
}