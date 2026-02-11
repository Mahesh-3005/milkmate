
import 'package:get/get.dart';
import 'package:milklog/getx/services/s.login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProcessingController extends GetxController {
  final LoginService slogin = LoginService();

  var statusText = 'Verifying credentials...'.obs;
  var isSuccess = false.obs;
  var isFailure = false.obs;

  @override
  void onInit() {
    super.onInit();
    _processLogin();
  }

  Future<void> _processLogin() async {
    final args = Get.arguments;
    final phone = args['phone'];
    final password = args['password'];

    await Future.delayed(const Duration(milliseconds: 600));

    final role = await slogin.authenticateUser(phone, password);

    /// ❌ FAILURE FLOW (ANIMATED)
    if (role != 'Admin' && role != 'Customer') {
      statusText.value = 'Invalid credentials';
      isFailure.value = true;

      await Future.delayed(const Duration(milliseconds: 900));

      Get.offAllNamed('/login');
      Get.snackbar(
        'Login failed',
        'Wrong phone number or password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    /// ✅ SUCCESS FLOW
    statusText.value = 'Fetching your data...';
    final user = await slogin.getUserInfo(phone, role);

    statusText.value = 'Saving session...';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user['id']);
    await prefs.setString('role', role);

    statusText.value = 'Syncing data...';

    if (role == 'Admin') {
      await slogin.initialSync(
        user['id'],
        user['organization_id'],
      );
    } else {
      await slogin.initialUserSync(
        user['id'],
        user['organization_id'],
        user['admin_id'],
      );
    }

    statusText.value = 'Preparing dashboard...';
    isSuccess.value = true;

    await Future.delayed(const Duration(milliseconds: 700));

    role == 'Admin'
        ? Get.offAllNamed('/home')
        : Get.offAllNamed('/customerhome');
  }
}


// class LoginProcessingController extends GetxController {
//   final LoginService slogin = LoginService();

//   var statusText = 'Verifying credentials...'.obs;
//   var isSuccess = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     Future.microtask(_processLogin); // 🔑 avoids rebuild loop
//   }

//   Future<void> _processLogin() async {
//     try {
//       final args = Get.arguments;
//       final phone = args['phone'];
//       final password = args['password'];

//       await Future.delayed(const Duration(milliseconds: 600));

//       final role = await slogin.authenticateUser(phone, password);

//       /// ❌ INVALID LOGIN
//       if (role != 'Admin' && role != 'Customer') {
//         Get.offAllNamed('/login'); // 🔥 NOT Get.back()
//         Get.snackbar(
//           'Login failed',
//           'Wrong phone number or password',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       statusText.value = 'Fetching your data...';
//       final user = await slogin.getUserInfo(phone, role);

//       statusText.value = 'Saving session...';
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('id', user['id']);
//       await prefs.setString('role', role);

//       statusText.value = 'Syncing data...';

//       if (role == 'Admin') {
//         await slogin.initialSync(
//           user['id'],
//           user['organization_id'],
//         );
//       } else {
//         await slogin.initialUserSync(
//           user['id'],
//           user['organization_id'],
//           user['admin_id'],
//         );
//       }

//       statusText.value = 'Preparing dashboard...';
//       isSuccess.value = true;

//       await Future.delayed(const Duration(milliseconds: 500));

//       role == 'Admin'
//           ? Get.offAllNamed('/home')
//           : Get.offAllNamed('/customerhome');
//     } catch (e) {
//       Get.offAllNamed('/login');
//       Get.snackbar('Error', 'Something went wrong');
//     }
//   }
// }



// class LoginProcessingController extends GetxController {
//   final LoginService slogin = LoginService();

//   var statusText = 'Verifying credentials...'.obs;
//   var isSuccess = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _processLogin();
//   }

//   Future<void> _processLogin() async {
//     final args = Get.arguments;
//     final phone = args['phone'];
//     final password = args['password'];

//     await Future.delayed(const Duration(milliseconds: 700));

//     final role = await slogin.authenticateUser(phone, password);

//     if (role == 'Customer' || role == 'Admin') {
//       statusText.value = 'Fetching your data...';

//       final user = await slogin.getUserInfo(phone, role);

//       statusText.value = 'Preparing dashboard...';

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('id', user['id']);
//       await prefs.setString('role', role);

//       await Future.delayed(const Duration(milliseconds: 700));

//       /// ✅ SUCCESS STATE
//       isSuccess.value = true;

//       await Future.delayed(const Duration(milliseconds: 900));

//       if (role == 'Admin') {
//         Get.offAllNamed('/home');
//         Future.microtask(() => slogin.initialSync(
//               user['id'],
//               user['organization_id'],
//             ));
//       } else {
//         Get.offAllNamed('/customerhome');
//         Future.microtask(() => slogin.initialUserSync(
//               user['id'],
//               user['organization_id'],
//               user['admin_id'],
//             ));
//       }
//     } else {
//       Get.back();
//       Get.snackbar('Error', 'Account not found');
//     }
//   }
// }


// class LoginProcessingController extends GetxController {
//   final LoginService slogin = LoginService();

//   var statusText = 'Verifying credentials...'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _processLogin();
//   }

//   Future<void> _processLogin() async {
//     final args = Get.arguments as Map<String, dynamic>;
//     final phone = args['phone'];
//     final password = args['password'];

//     await Future.delayed(const Duration(milliseconds: 600));

//     final role = await slogin.authenticateUser(phone, password);

//     if (role == 'Customer' || role == 'Admin') {
//       statusText.value = 'Fetching account data...';

//       final user = await slogin.getUserInfo(phone, role);

//       statusText.value = 'Preparing dashboard...';

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('id', user['id']);
//       await prefs.setString('role', role);

//       /// Small delay to feel smooth
//       await Future.delayed(const Duration(milliseconds: 500));

//       if (role == 'Admin') {
//         Get.offAllNamed('/home');
//         Future.microtask(() => slogin.initialSync(
//               user['id'],
//               user['organization_id'],
//             ));
//       } else {
//         Get.offAllNamed('/customerhome');
//         Future.microtask(() => slogin.initialUserSync(
//               user['id'],
//               user['organization_id'],
//               user['admin_id'],
//             ));
//       }
//     } else {
//       Get.back();
//       Get.snackbar('Error', 'Account not found');
//     }
//   }
// }
