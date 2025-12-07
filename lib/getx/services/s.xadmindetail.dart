import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/organization.dart';

import '../../hive_model/admin.dart';

class XAdminDetailService extends GetxService {
  final Box<Admin> adminBox = Hive.box<Admin>('Admin');
  final Box<Organization> organizationBox = Hive.box<Organization>('Organization');
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');

  getOrganizationName(String organizationId) {
    try {
      final org = organizationBox.get(organizationId);
      return org?.name ?? '-';
    } catch (e) {
      print('Error fetching organization name: $e');
      return '-';
    }

  }
}