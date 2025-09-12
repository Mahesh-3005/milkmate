import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/services/s.addcustomer.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:uuid/uuid.dart';

class AddCustomerController extends GetxController {
  final TextEditingController fnameCtrl = TextEditingController();
  final TextEditingController mnameCtrl = TextEditingController();
  final TextEditingController lnameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController quantityCtrl = TextEditingController();
  final TextEditingController rateCtrl = TextEditingController();
  final TextEditingController milkTypeCtrl = TextEditingController();
  final TextEditingController deliveryTimeCtrl = TextEditingController();
  final TextEditingController addressCtrl= TextEditingController();
  final service = AddCustomerService();
  Customer customer = Customer(id: '', firstName: '', middleName: '', lastName: '', phone: '', address: '', rate: 0.0, quantity: 0.0, milkType: '', deliveryTime: '', organizationId: '', adminId: '', isDeleted: false, createdAt: DateTime.now(), updatedAt: DateTime.now());

  @override
  void onInit() {
    super.onInit();
  }

  saveCustomer() async {
    if (!validation()) return false;
    Admin? admin = service.getAdminInfo();
    if (admin != null) {
    customer.id = Uuid().v4();
    customer.firstName = fnameCtrl.text.trim();
    customer.middleName = mnameCtrl.text.trim();
    customer.lastName = lnameCtrl.text.trim();
    customer.phone = phoneCtrl.text.trim();
    customer.address = addressCtrl.text.trim();
    customer.rate = double.tryParse(rateCtrl.text.trim()) ?? 0.0;
    customer.quantity = double.tryParse(quantityCtrl.text.trim()) ?? 0.0;
    customer.milkType = milkTypeCtrl.text.trim();
    customer.deliveryTime = deliveryTimeCtrl.text.trim();
    customer.adminId = admin.id;
    customer.organizationId = admin.organizationId;
    customer.isSynced = false;
    await service.saveCustomer(customer);
    Get.snackbar('Success','New Customer added Successfully');
    return true;
    } else {
      Get.snackbar("Error", "Admin is Empty");      
    }
  }

  bool fnameValidator(String fname) {
    if (fname.isEmpty) {
      Get.snackbar("Error", "first name is Empty");
      return false;
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(fname)) {
      Get.snackbar("Error", "First Name should contains only alphabet");
      return false;
    }
    return true;
  }

  bool lnameValidator(String lname) {
    if (lname.isEmpty) {
      Get.snackbar("Error", "Last name is Empty");
      return false;
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(lname)) {
      Get.snackbar("Error", "Last Name should contains only alphabet");
      return false;
    }
    return true;
  }

  bool phoneValidator(String phone) {
    if (phone.isEmpty) {
      Get.snackbar("Error", "Phone No. is Empty");
      return false;
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
      Get.snackbar("Error", "Enter Valid 10 digit number");
      return false;
    }
    final isUnique = service.isPhoneExist(phone);
    if (!isUnique) {
      Get.snackbar('Error', 'Phone no. already exist');
      return false;
    }
    return true;
  }
  
  bool addressValidator(String address) {
    if (address.isEmpty) {
      Get.snackbar("Error", "Address is Empty");
      return false;
    }
    return true;
  }

  bool quantityValidator(String quantity) {
    if (quantity.isEmpty) {
      Get.snackbar("Error", "quantity is Empty");
      return false;
    }
    return true;
  }

  bool rateValidator(String rate) {
    if (rate.isEmpty) {
      Get.snackbar("Error", "rate is Empty");
      return false;
    }
    return true;
  }

  bool milkTypeValidator(String milkType) {
    if (milkType.isEmpty) {
      Get.snackbar("Error", "milkType is Empty");
      return false;
    }
    return true;
  }

  bool deliveryTimeValidator(String deliveryTime) {
    if (deliveryTime.isEmpty) {
      Get.snackbar("Error", "Address is Empty");
      return false;
    }
    return true;
  }

  bool validation() {
    if (!fnameValidator(fnameCtrl.text.trim())) return false;
    if (!lnameValidator(lnameCtrl.text.trim())) return false;
    if (!phoneValidator(phoneCtrl.text.trim())) return false;
    if (!addressValidator(addressCtrl.text.trim())) return false;
    if (!quantityValidator(quantityCtrl.text.trim())) return false;
    if (!rateValidator(rateCtrl.text.trim())) return false;
    if (!milkTypeValidator(milkTypeCtrl.text.trim())) return false;
    if (!deliveryTimeValidator(deliveryTimeCtrl.text.trim())) return false;
    return true;
  }

  @override
  void onClose() {
    super.onClose();
  }
}