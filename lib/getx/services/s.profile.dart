import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/organization.dart';

class ProfileService extends GetxService {
  final Box<Admin> adminBox = Hive.box<Admin>('Admin');
  final Box<Organization> organizationBox = Hive.box<Organization>('Organization');

  Admin? getAdminInfo() {
    if (adminBox.isNotEmpty) {
      return adminBox.values.first;
    } else {
      return null;
    }
  }

  Organization? getOrganizationInfo(String organizationId) {
    if (organizationBox.isNotEmpty) {
      return organizationBox.values.firstWhere((e) => e.id == organizationId);
    } else {
      return null;
    }
  }

  // Future<Map<String,dynamic>> getAdminDetails(String id) async {
  //   try {
  //     final response = await supabase.from('Admin').select().eq('id', id).eq('is_deleted', false).single();
  //     return response;
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }

  // Future<Map<String,dynamic>> getOrganizationName(String id) async {
  //   try {
  //     final response = await supabase.from('Organization').select('name').eq('id', id).eq('is_deleted', false).single();
  //     return response;
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }
}
