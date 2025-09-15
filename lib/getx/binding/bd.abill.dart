import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.abill.dart';

class ABillBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ABillController>(()=> ABillController());
  } 
}