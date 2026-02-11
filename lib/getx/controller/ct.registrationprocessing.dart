import 'package:get/get.dart';
import 'package:milklog/getx/services/s.registration.dart';

class RegistrationProcessingController extends GetxController {
  final RegistrationService sregistration = RegistrationService();

  var statusText = 'Validating details...'.obs;
  var isSuccess = false.obs;
  var isFailure = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.microtask(_processRegistration);
  }

  Future<void> _processRegistration() async {
    try {
      final args = Get.arguments;
      final phone = args['admin']['phone'];
      final key = args['org']['key'];

      /// STEP 1️⃣ PRE-CHECKS (FAST)
      await Future.delayed(const Duration(milliseconds: 400));

      if (await sregistration.isPhoneExist(phone)) {
        _fail('Phone number already exists');
        return;
      }

      if (await sregistration.isKeyExist(key)) {
        _fail('Organization key already exists');
        return;
      }

      /// STEP 2️⃣ CREATE ORGANIZATION
      statusText.value = 'Setting up organization...';
      final orgId = await sregistration.createNewOrganization(args['org']);

      if (orgId == null) {
        _fail('Organization creation failed');
        return;
      }

      /// STEP 3️⃣ CREATE ADMIN
      statusText.value = 'Creating admin account...';

      final adminData = {
        ...args['admin'],
        'organization_id': orgId,
      };

      try {
  await sregistration.saveAdmin(
    args['admin'],
    args['password'],
  );
} catch (e) {
  _fail('Account creation failed');
  return;
}

      // final success = await sregistration.saveAdmin(
      //   adminData,
      //   args['password'],
      // );

      // if (!success) {
      //   _fail('Account creation failed');
      //   return;
      // }

      /// STEP 4️⃣ SUCCESS
      statusText.value = 'Finalizing setup...';
      await Future.delayed(const Duration(milliseconds: 600));

      isSuccess.value = true;
      statusText.value = 'Account created successfully';

      await Future.delayed(const Duration(milliseconds: 900));
      Get.offAllNamed('/login');
    } catch (e) {
      _fail('Something went wrong');
    }
  }

  void _fail(String message) async {
    isFailure.value = true;
    statusText.value = message;

    await Future.delayed(const Duration(milliseconds: 1300));
    Get.offAllNamed('/register');
  }
}


// class RegistrationProcessingController extends GetxController {
//   final RegistrationService sregistration = RegistrationService();

//   var statusText = 'Creating account...'.obs;
//   var isSuccess = false.obs;
//   var isFailure = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     Future.microtask(_processRegistration);
//   }

//   Future<void> _processRegistration() async {
//     try {
//       final args = Get.arguments;

//       await Future.delayed(const Duration(milliseconds: 600));
//       statusText.value = 'Setting up organization...';

//       final orgId = await sregistration.createNewOrganization(args['org']);

//       if (orgId == null) {
//         _fail('Organization creation failed');
//         return;
//       }

//       statusText.value = 'Creating admin account...';

//       // final success = await sregistration.saveAdmin(
//       //   args['admin'],
//       //   args['password'],
//       // );

//       // if (!success) {
//       //   _fail('Account creation failed');
//       //   return;
//       // }
//       try {
//   await sregistration.saveAdmin(
//     args['admin'],
//     args['password'],
//   );
// } catch (e) {
//   _fail('Account creation failed');
//   return;
// }


//       statusText.value = 'Finalizing setup...';
//       await Future.delayed(const Duration(milliseconds: 500));

//       /// ✅ SUCCESS
//       isSuccess.value = true;
//       statusText.value = 'Account created successfully';

//       await Future.delayed(const Duration(milliseconds: 800));
//       Get.offAllNamed('/login');
//     } catch (e) {
//       _fail('Something went wrong');
//     }
//   }

//   void _fail(String message) async {
//     isFailure.value = true;
//     statusText.value = message;

//     await Future.delayed(const Duration(milliseconds: 1200));
//     Get.offAllNamed('/register');
//   }
// }


// class RegistrationProcessingController extends GetxController {
//   final RegistrationService sregistration = RegistrationService();

//   var hasError = false.obs;
//   var errorMessage = ''.obs;
//   RxString statusText = 'Creating account...'.obs;
// RxString subText = 'Please wait'.obs;
// RxBool isSuccess = false.obs;
// // RxBool hasError = false.obs;


//   @override
//   void onInit() {
//     super.onInit();
//     _startRegistration();
//   }

//   Future<void> _startRegistration() async {
//     try {
//       final args = Get.arguments;

//       bool isPhoneExist =
//           await sregistration.isPhoneExist(args['phone']);
//       if (isPhoneExist) {
//         throw 'Phone number already exists';
//       }

//       bool isKeyExist =
//           await sregistration.isKeyExist(args['key']);
//       if (isKeyExist) {
//         throw 'Organization key already exists';
//       }

//       final orgId = await sregistration.createNewOrganization({
//         'key': args['key'],
//         'name': args['organization'],
//       });

//       await sregistration.saveAdmin(
//         {
//           'firstname': args['fname'],
//           'lastname': args['lname'],
//           'phone': args['phone'],
//           'organization_id': orgId,
//         },
//         args['password'],
//       );

//       /// ✅ Success animation delay
//       await Future.delayed(const Duration(seconds: 1));

//       Get.offAllNamed('/login');
//     } catch (e) {
//       hasError.value = true;
//       errorMessage.value = e.toString();

//       /// ❌ Failure animation then go back
//       await Future.delayed(const Duration(seconds: 2));
//       Get.back();

//       Get.snackbar('Registration Failed', errorMessage.value);
//     }
//   }
// }
