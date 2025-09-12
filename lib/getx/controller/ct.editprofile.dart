import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:milklog/getx/services/s.editprofile.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/organization.dart';

class EditProfilePageController extends GetxController {
  late TextEditingController fnameCtrl;
  late TextEditingController mnameCtrl;
  late TextEditingController lnameCtrl;
  late TextEditingController addressCtrl;
  late TextEditingController organizationCtrl;
  late TextEditingController organizationKeyCtrl;
  final EditProfileService service = EditProfileService();

  @override
  void onInit() async {
    await loadEditProfilePage();
    super.onInit();
  }

  loadEditProfilePage() async {
    Admin? admin = service.getAdminInfo();
    if (admin != null) {
      fnameCtrl = TextEditingController(text: admin.firstName);
      mnameCtrl = TextEditingController(text: admin.middleName);
      lnameCtrl = TextEditingController(text: admin.lastName);
      addressCtrl = TextEditingController(text: admin.address);
      Organization? organization = service.getOrganizationInfo(
        admin.organizationId,
      );
      if (organization != null) {
        organizationCtrl = TextEditingController(text: organization.name);
        organizationKeyCtrl = TextEditingController(text: organization.key);
      } else {
        Get.snackbar('Error', 'Cannot find Organization');
      }
    } else {
      Get.snackbar('Error', 'Cannot find Admin');
    }
  }

  save() async {
    Admin? admin = service.getAdminInfo();
    if (admin != null) {
      Organization? organization = service.getOrganizationInfo(
        admin.organizationId,
      );
      if (organization != null) {
        organization.name = organizationCtrl.text.trim();
        organization.key = organizationKeyCtrl.text.trim();
        organization.isSynced = false;
        final data = await service.editOrganizationData(
          organization.id,
          organization
        );
        admin.firstName = fnameCtrl.text.trim();
        admin.middleName = mnameCtrl.text.trim();
        admin.lastName = lnameCtrl.text.trim();
        admin.address = addressCtrl.text.trim();
        admin.isSynced = false;
        final data2 = await service.editAdminData(
          admin.id,
          admin,
        );
        Get.snackbar('Success', 'Your Profile Updated Successfully');
        return true;
      } else {
        Get.snackbar('Error', 'Cannot find Organization');
      }
    } else {
      Get.snackbar('Error', 'Cannot find Admin');
    }
  }
}
