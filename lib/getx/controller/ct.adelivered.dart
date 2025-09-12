import 'package:get/get.dart';
import 'package:milklog/getx/services/s.adelivered.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:uuid/uuid.dart';

class ADeliveredController extends GetxService {
  final service = ADeliveredService();
  RxList<Customer> customerList = <Customer>[].obs;
  RxSet<int> selected = <int>{}.obs;
  RxSet<String> selectedIds = <String>{}.obs;
  Delivered delivered = Delivered(id: '', customerId: '', date: DateTime(2000,1,1), createdAt: DateTime.now(), isDeleted: false);
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    selectedIds.clear();
    customerList.value = service.getCustomerList();
    super.onInit();
  }

  
  isTodayMarked() {
    print(selectedDate.value);
    bool marked = service.isTodayMarked(selectedDate.value);
    if (marked) {
      Get.snackbar('Already Marked', '');
    } else {
      Get.snackbar('Not Marked', '');
    }
  }

  void toggle(int index,String customerid) {
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

  saveCustomer(){
    var today = selectedDate.value;
    // final dateOnly = DateTime(today.year, today.month, today.day);
    for (var id in selectedIds) {
      final newDelivered = Delivered(id: Uuid().v4(), customerId: id, date: today, createdAt: DateTime.now(), isDeleted: false,isSynced: false);
      // delivered.date = DateTime.now().toIso8601String().split('T').first;
      service.saveCustomer(newDelivered);
    }
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  @override
  void onClose() {
    selectedIds.clear();
    super.onClose();
  }
}
