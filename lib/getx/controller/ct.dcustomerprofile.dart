import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/services/s.dcustomerprofile.dart';
import 'package:milklog/hive_model/customer.dart';

class DCustomerProfileController extends GetxController {
  late TextEditingController fnameCtrl = TextEditingController();
  late TextEditingController mnameCtrl= TextEditingController();
  late TextEditingController lnameCtrl= TextEditingController();
  late TextEditingController phoneCtrl= TextEditingController();
  late TextEditingController addressCtrl= TextEditingController();
  late TextEditingController quantityCtrl= TextEditingController();
  late TextEditingController rateCtrl= TextEditingController();
  late TextEditingController milkTypeCtrl= TextEditingController();
  late TextEditingController deliveryTimeCtrl;
  final service = DCustomerProfileService();

  @override
  void onInit() async {
    await setarguments();
    super.onInit();
  }

  setarguments() async {
    if (Get.arguments != null) {
      final id = Get.arguments['id'];
      Customer customer = service.getCustomerDetails(id);
      fnameCtrl = TextEditingController(text: customer.firstName);
      lnameCtrl = TextEditingController(text: customer.lastName);
      mnameCtrl = TextEditingController(text: customer.middleName);
      phoneCtrl = TextEditingController(text: customer.phone);
      addressCtrl = TextEditingController(text: customer.address);
      rateCtrl = TextEditingController(text: customer.rate.toString());
      quantityCtrl = TextEditingController(text: customer.quantity.toString());
      milkTypeCtrl = TextEditingController(text: customer.milkType);
      deliveryTimeCtrl = TextEditingController(text: customer.deliveryTime);
    }
  }

  Future<bool> save() async {
    if (!validation()) return false;
    if (Get.arguments != null) {
      final id = Get.arguments['id'];
      Customer customer = service.getCustomerDetails(id);
      final isUnique = service.isPhoneExist(phoneCtrl.text.trim(),customer.id);
    if (!isUnique) {
      Get.snackbar('Error', 'Phone no. already exist');
      return false;
    }
      customer.firstName = fnameCtrl.text.trim();
      customer.middleName = mnameCtrl.text.trim();
      customer.lastName = lnameCtrl.text.trim();
      customer.address = addressCtrl.text.trim();
      customer.phone = phoneCtrl.text.trim();
      customer.rate = double.tryParse(rateCtrl.text.trim())!;
      customer.quantity = double.tryParse(quantityCtrl.text.trim())!;
      customer.milkType = milkTypeCtrl.text.trim();
      customer.deliveryTime = deliveryTimeCtrl.text.trim();
      customer.isSynced = false;
      service.updateCustomer(customer);
    }
    return true;
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

  
  setDetails() async {
    final data = {
      'quantity':double.parse(quantityCtrl.text.trim(),),
      'rate':double.parse(rateCtrl.text.trim(),),
      'milk_type':milkTypeCtrl.text.trim(),
      'delivery_time':deliveryTimeCtrl.text.trim(),
    };
    // await service.updateCustomerDetail(data,id);
  }
}