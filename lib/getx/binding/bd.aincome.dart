import 'package:get/get.dart';
import 'package:milklog/getx/controller/ct.aincome.dart';

class AIncomeBimding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AIncomeController>(()=> AIncomeController());
  } 
}