import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationService extends GetxService {
  final supabase = Supabase.instance.client;

  Future<bool> isPhoneExist(String phone) async {
    try {
      final response = await supabase
          .from('Appuser')
          .select('role')
          .eq('phone', phone)
          .eq('is_deleted', false);
      if (response.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  Future<bool> isKeyExist(String key) async {
    try {
      final response = await supabase
          .from('Organization')
          .select('key')
          .eq('key', key)
          .eq('is_deleted', false);
      if (response.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  Future<String> createNewOrganization(Map orgData) async {
    try {
      final response =
          await supabase.from('Organization').insert(orgData).select();
      var id = response[0];
      print('Get organization id');
      return id['id'];
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  Future<void> saveAdmin(data,password) async {
    try {
      final response = await supabase.from('Admin').insert(data).select();
      print('New Admin Created');
      final appuser = response[0];
      final appuserdata = {
        'referenceid': appuser['id'],
        'phone': appuser['phone'],
        'password': password,
        'role': 'Admin',
        // 'created_at':appuser['created_at']
      };
      final appuserResponse =
          await supabase.from('Appuser').insert(appuserdata).select();
      print('New Appuser Created');
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  Future<String> getOrganizationId(String key) async {
    try {
      final response = await supabase
        .from('Organization')
        .select('id')
        .eq('key', key)
        .eq('is_deleted', false);
    if (response.isEmpty) {
      return "false";
    } else {
      var id = response[0];
      return id['id'];
    }
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  // Future<String?> getAdminId(String id) async {
  //   try {
  //     final response = await supabase
  //       .from('Admin')
  //       .select('id')
  //       .eq('organization_id', id)
  //       .eq('is_deleted', false);
  //   if (response.isNotEmpty) {
  //     var admin = response[0];
  //     return admin['id'];
  //   }
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }

  // Future<void> saveCustomer(data) async {
  //   try {
  //     final response = await supabase.from('Customer').insert(data).select();
  //     print('New Customer Created');
  //     final appuser = response[0];
  //     final appuserdata = {
  //       'referenceid': appuser['id'],
  //       'phone': appuser['phone'],
  //       'password': appuser['password'],
  //       'role': 'Customer',
  //       // 'created_at':appuser['created_at']
  //     };
  //     final appuserResponse =
  //         await supabase.from('Appuser').insert(appuserdata).select();
  //     print('New Appuser Created');
  //   } catch (e) {
  //     print('Error:$e');
  //     rethrow;
  //   }
  // }
}
