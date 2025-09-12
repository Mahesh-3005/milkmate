import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.editprofile.dart';

class EditProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfilePageController>(()=>EditProfilePageController());
  }
}