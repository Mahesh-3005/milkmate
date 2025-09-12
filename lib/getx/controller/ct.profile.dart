import 'package:get/get.dart';
import 'package:milklog/getx/services/s.profile.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/organization.dart';

class ProfileController extends GetxController {
  final ProfileService sprofile = ProfileService();
  RxString firstname = ''.obs;
  RxString middlename = ''.obs;
  RxString lastname = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxString organizationname = ''.obs;
  RxString organizationkey = ''.obs;
  final ProfileService service = ProfileService();

  @override
  void onInit() async {
    await getAdminDetails();
    super.onInit();
  }

  getAdminDetails() async {
    Admin? admin = service.getAdminInfo();
    if (admin != null) {
      firstname.value = admin.firstName;
      middlename.value = admin.middleName;
      lastname.value = admin.lastName;
      phone.value = admin.phone;
      address.value = admin.address;
      var organizationId = admin.organizationId;
      Organization? organization = service.getOrganizationInfo(
        organizationId,
      );
      if (organization != null) {
        organizationname.value = organization.name;
        organizationkey.value = organization.key;
      } else {
        Get.snackbar('Error', 'Cannot find Organization');
      }
    } else {
      Get.snackbar('Error', 'Cannot find Admin');
    }

    // final pref = await SharedPreferences.getInstance();
    // String? id = pref.getString('id');
    // if (id != null) {
    //   admin.value = await sprofile.getAdminDetails(id);
    //   var orgId = admin['organization_id'];
    //   var orgname = await sprofile.getOrganizationName(orgId);
    //   firstname.value = admin['firstname'];
    //   middlename.value = admin['middlename'];
    //   lastname.value = admin['lastname'];
    //   phone.value = admin['phone'];
    //   address.value = admin['address'];
    //   organizationname.value = orgname['name'];
    // } else {
    //   Get.snackbar('Error', "Admin does not found");
    // }
  }
}
