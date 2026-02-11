import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/services/s.registration.dart';

class RegistrationController extends GetxController {
  final TextEditingController fnameCtrl = TextEditingController();
  final TextEditingController lnameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController organizationCtrl = TextEditingController();
  final TextEditingController keyCtrl = TextEditingController();
  final RegistrationService sregistration = RegistrationService();
  // RxBool isAdmin = false.obs;
  // RxInt toggleIndex = 1.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
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

  bool passwordValidator(String password) {
    if (password.isEmpty) {
      Get.snackbar("Error", "Password is Empty");
      return false;
    }
    if (password.length < 6) {
      Get.snackbar("Error", "Password length must be at least 6 characters");
      return false;
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      Get.snackbar(
        "Error",
        "Password must contains at least one lowercase Character",
      );
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      Get.snackbar(
        "Error",
        "Password must contains at least one Uppercase Character",
      );
      return false;
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      Get.snackbar("Error", "Password must contains at least one number");
      return false;
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      Get.snackbar(
        "Error",
        "Password must contains at least one special character",
      );
      return false;
    }
    return true;
  }

  bool keyValidator(String key) {
    if (key.isEmpty) {
      Get.snackbar('Error', "Organization key is Empty");
      return false;
    }
    if (key.length < 6) {
      Get.snackbar("error", "Key length must be greater than 6");
      return false;
    }
    return true;
  }

  bool validation() {
    if (!fnameValidator(fnameCtrl.text.trim())) return false;
    if (!lnameValidator(lnameCtrl.text.trim())) return false;
    if (!phoneValidator(phoneCtrl.text.trim())) return false;
    if (!passwordValidator(passwordCtrl.text.trim())) return false;
    if (!keyValidator(keyCtrl.text.trim())) return false;
  
    return true;
  }

    void performOperation() {
    if (!validation()) return;
Get.toNamed(
  '/registration-processing',
  arguments: {
    'org': {
      'key': keyCtrl.text.trim(),
      'name': organizationCtrl.text.trim(),
    },
    'admin': {
      'firstname': fnameCtrl.text.trim(),
      'lastname': lnameCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'organization_id': null, // set after org creation
    },
    'password': passwordCtrl.text.trim(),
  },
);

    }

    /// 🚀 Move instantly to processing screen
  //   Get.toNamed(
  //     '/registration-processing',
  //     arguments: {
  //       'fname': fnameCtrl.text.trim(),
  //       'lname': lnameCtrl.text.trim(),
  //       'phone': phoneCtrl.text.trim(),
  //       'password': passwordCtrl.text.trim(),
  //       'organization': organizationCtrl.text.trim(),
  //       'key': keyCtrl.text.trim(),
  //     },
  //   );
  // }

  // performOperation() async {
  //   // value == 0 ? isAdmin.value = true : isAdmin.value = false;
  //   if (await save()) {
  //     Get.offAllNamed('/login');
  //   }                                                    
  // }

  // save() async {
  //   if (!validation()) return false;
  //    /// 🚀 Move instantly to processing screen
  //   Get.toNamed(
  //     '/registration-processing',
  //     arguments: {
  //       'fname': fnameCtrl.text.trim(),
  //       'lname': lnameCtrl.text.trim(),
  //       'phone': phoneCtrl.text.trim(),
  //       'password': passwordCtrl.text.trim(),
  //       'organization': organizationCtrl.text.trim(),
  //       'key': keyCtrl.text.trim(),
  //     },
  //   );
  //   // bool isPhoneExist = await sregistration.isPhoneExist(phoneCtrl.text.trim());
  //   // bool isKeyExist = await sregistration.isKeyExist(keyCtrl.text.trim());
  //   // if (isPhoneExist) {
  //   //   Get.snackbar(
  //   //     "Error",
  //   //     'Phone no. is already exist \nTry Using another Number',
  //   //   );
  //   //   return false;
  //   // } else if (isKeyExist) {
  //   //   Get.snackbar("Error", 'Use Another Key');
  //   //   return false;
  //   // } else {
  //   //   // isAdmin.value ? await setAdminDetails() : await setCustomerDetails();
  //   //   await setAdminDetails();
  //   // }
  //   return true;
  // }

  // setAdminDetails() async {
  //   final orgData = {
  //     'key': keyCtrl.text.trim(),
  //     'name': organizationCtrl.text.trim(),
  //   };
  //   final orgid = await sregistration.createNewOrganization(orgData);
  //   final adminData = {
  //     'firstname': fnameCtrl.text.trim(),
  //     'lastname': lnameCtrl.text.trim(),
  //     'phone': phoneCtrl.text.trim(),
  //     // 'password': passwordCtrl.text.trim(),
  //     'organization_id': orgid,
  //     // 'created_at': DateTime.now().toUtc().toIso8601String(),
  //   };
  //   await sregistration.saveAdmin(adminData,passwordCtrl.text.trim());
  //   Get.snackbar('Success', 'Organization Created');
  // }

  @override
  void onClose() {
    // fnameCtrl.dispose();
    // lnameCtrl.dispose();
    // phoneCtrl.dispose();
    // passwordCtrl.dispose();
    // cpasswordCtrl.dispose();
    // organizationCtrl.dispose();
    super.onClose();
  }
}
