import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/services/s.login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final LoginService slogin = LoginService();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onInit() async {
    await goToHomePage();
    super.onInit();
  }

  goToHomePage() async {
    final loggedIn = await isLoggedIn();
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    if (loggedIn && role == 'Customer') {
      await Get.offAllNamed('/customerhome');
    } else if(loggedIn && role == 'Admin') {
      await Get.offAllNamed('/home');
    } else{
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('id');
}

  @override
  void onClose() {
    // phoneCtrl.dispose();
    // passwordCtrl.dispose();
    super.onClose();
  }

  login() async {
     /// 🚀 INSTANT TRANSITION
  Get.toNamed(
    '/login-processing',
    arguments: {
      'phone': phoneCtrl.text.trim(),
      'password': passwordCtrl.text.trim(),
    },
  );
    //  isLoading.value = true;

    // // simulate API
    // await Future.delayed(const Duration(seconds: 2));

    // isLoading.value = false;

    // final isUserPresent = await slogin.authenticateUser(
    //   phoneCtrl.text.trim(),
    //   passwordCtrl.text.trim(),
    // );
    // if (isUserPresent == 'Customer' || isUserPresent == 'Admin') {
    //   final user = await slogin.getUserInfo(
    //     phoneCtrl.text.trim(),
    //     isUserPresent,
    //   );
    //   isUserPresent == 'Admin'
    //       ? saveAdminSession(user)
    //       : saveCustomerSession(user);
    //   Get.snackbar("Success", "Login Successful");
    // } else {
    //   Get.snackbar("Error", "You Account is not created yet");
    // }
  }

  // Future<void> saveAdminSession(Map<String, dynamic> user) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('id', user['id']);
  //   await prefs.setString('role', 'Admin');
  //   await slogin.initialSync(user['id'],user['organization_id']);
  //   Get.offAllNamed('/home');
  // }

  // Future<void> saveCustomerSession(Map<String, dynamic> user) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('id', user['id']);
  //   await prefs.setString('role','Customer');
  //   await slogin.initialUserSync(user['id'],user['organization_id'],user['admin_id']);
  //   Get.offAllNamed('/customerhome');
  // }
}
