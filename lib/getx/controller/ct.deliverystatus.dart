import 'package:get/get.dart';
import 'package:milklog/getx/services/s.deliverystatus.dart';

class DeliveryStatusController extends GetxController {
  RxList<DateTime> deliveryDates = <DateTime>[].obs; 
  final service = DeliveryStatusService();

  @override
  void onInit() {
    loadPage();
    super.onInit();
  }

  loadPage()  {
  // Customer customer = service.getCustomerDetails();
  deliveryDates.value =  service.getDeliveredDates();
  }
}