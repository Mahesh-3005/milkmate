import 'package:get/get.dart';
import 'package:milklog/getx/services/s.extradelivered.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:uuid/uuid.dart';

class ExtraDeliveredController extends GetxController {
  RxList<Customer> customerList = <Customer>[].obs;
  RxList<Customer> newCustomerList = <Customer>[].obs;
  final service = ExtraDeliveredService();
  RxSet<int> selected = <int>{}.obs;
  RxSet<String> selectedIds = <String>{}.obs;
  var selectedDate = DateTime.now().obs;
  // List<TextEditingController> text = [];
  var extraQtyMap = <String, double>{}.obs;

  void setExtraQty(String customerId, double qty) {
    extraQtyMap[customerId] = qty;
    print(extraQtyMap);
  }

  var index = 0.obs;

  void next() {
    index.value++;
  }

  getNewCustomerList(){
    if (selectedIds.isNotEmpty) {
      for (var id in selectedIds) {
      Customer customer = service.getCustomer(id);
      newCustomerList.add(customer);
    }
    print(newCustomerList);
    return true;
    } else {
    Get.snackbar('Select Someone', 'You not selected anyone');
    return false;  
    }
  }

  bool saveExtraDeliveries() {
    if (selectedIds.length == extraQtyMap.length) {
      final deliveries = newCustomerList.map((customer) {
      final qty = extraQtyMap[customer.id] ?? 0;
      return Edelivered(
        id: Uuid().v4(),
        customerId: customer.id,
        date: selectedDate.value,
        quantity: qty, createdAt: DateTime.now(), isDeleted: false,isSynced: false
      );
    }).toList();

     for (var delivery in deliveries) {
      service.saveExtraDeliveries(delivery);
    }
    
    print("Saved ${deliveries.length} extra deliveries");
    return true;
    } else {
      Get.snackbar('Error', 'Enter all quantity');
      return false;
    }
  }

  @override
  void onInit() async {
    newCustomerList.clear();
    customerList.value = service.getCustomerList();
    super.onInit();
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }


  void toggle(int index, String customerid) {
    if (selected.contains(index) && selectedIds.contains(customerid)) {
      selected.remove(index);
      selectedIds.remove(customerid);
      print(selected);
      print(selectedIds);
    } else {
      selected.add(index);
      selectedIds.add(customerid);
      print(selected);
      print(selectedIds);
    }
  }

  void selectAll() {
    selected.addAll(List<int>.generate(customerList.length, (i) => i));
    for (var element in customerList) {
      selectedIds.add(element.id);
    }
    print(selected);
    print(selectedIds);
  }

  void clearAll() {
    selected.clear();
    selectedIds.clear();
    print(selected);
    print(selectedIds);
  }

  bool isSelected(int index) => selected.contains(index);

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
