import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/organization.dart';

class EditProfileService extends GetxService{
  final Box<Admin> adminBox = Hive.box<Admin>('Admin');
  final Box<Organization> organizationBox = Hive.box<Organization>('Organization');

  Admin? getAdminInfo() => adminBox.isNotEmpty ? adminBox.values.first : null;

  Organization? getOrganizationInfo(String organizationId) {
    if (organizationBox.isNotEmpty) {
      return organizationBox.values.firstWhere((e) => e.id == organizationId);
    } else {
      return null;
    }
  }

  editOrganizationData(key,value){
    organizationBox.put(key, value);
    print(organizationBox.get(key));
  }

  editAdminData( key,value){
    adminBox.put(key, value);
    print(adminBox.get(key));
  }


  // Future<Map<String,dynamic>> getAdmin(String id) {
  //   try {
  //     final response =
  //       supabase
  //           .from('Admin')
  //           .select()
  //           .eq('id', id)
  //           .eq('is_deleted', false)
  //           .single();
  //           return response;
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }

  // Future<void> updateOrganizationName(String orgId,Map orgData) async {
  //   try {
  //     final response = await supabase.from('Organization').update(orgData).eq('id', orgId).select();
  //   } catch (e) {
  //     print('Error:$e');
  //   }
  // }

  // Future<void> updateAdminDetails(Map Data,String adminId) async {
  //   try {
  //     final response = await supabase.from('Admin').update(Data).eq('id', adminId).select();
  //   } catch (e) {
  //     print('Error:$e');
  //   }
  // }

  // Future<String> getOrganizationId(String adminId) async {
  //   try {
  //     final response = await supabase.from('Admin').select('organization_id').eq('id', adminId).single();
  //     return response['organization_id'];
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }
}
