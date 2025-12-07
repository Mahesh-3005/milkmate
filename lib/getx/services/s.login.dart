import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:milklog/hive_model/expense.dart';
import 'package:milklog/hive_model/income.dart';
import 'package:milklog/hive_model/organization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService extends GetxService {
  final supabase = Supabase.instance.client;

  Future<String> authenticateUser(phone, password) async {
    try {
      final response = await supabase
        .from('Appuser')
        .select('role')
        .eq('phone', phone)
        .eq('password', password)
        .eq('is_deleted', false);
    if (response.isNotEmpty) {
      var user = response[0];
      var role = user['role'];
      return role;
    } else {
      Get.snackbar('Error', 'You are not a valid User');
      return 'false';
    }
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String phone, String type) async {
    try {
      final response = await supabase
        .from(type)
        .select()
        .eq('phone', phone)
        .eq('is_deleted', false).single();
    return response;
    } catch (e) {
      print('Error:$e');
      rethrow;
    }
  }

  Future<void> initialSync(String adminId, String organizationId) async {
  final customerBox = Hive.box<Customer>('Customer');
  final organizationBox = Hive.box<Organization>('Organization');
  final adminBox = Hive.box<Admin>('Admin');
  final deliveredBox = Hive.box<Delivered>('Delivered');
  final edeliveredBox = Hive.box<Edelivered>('Edelivered');
  final expenseBox = Hive.box<ExpenseModel>('Expense');
  final incomeBox = Hive.box<IncomeModel>('Income');

  try {
    // 1. Fetch Admin record
    final adminResponse = await supabase
        .from('Admin')
        .select()
        .eq('id', adminId)
        .single();

    final admin = Admin.fromMap(adminResponse);
    await adminBox.put(admin.id, admin);

    // 2. Fetch Organizations
    final orgResponse = await supabase
        .from('Organization')
        .select()
        .eq('id', organizationId).single();

   
      final org = Organization.fromMap(orgResponse);
      await organizationBox.put(org.id, org);

    // 3. Fetch Customers
    final custResponse = await supabase
        .from('Customer')
        .select()
        .eq('admin_id', adminId);

    for (var item in custResponse) {
      final cust = Customer.fromMap(item);
      await customerBox.put(cust.id, cust);
    }

    final deliveredResponse = await supabase
        .from('Delivered')
        .select();
      
    for (var item in deliveredResponse) {
      final delivered = Delivered.fromMap(item);
      await deliveredBox.put(delivered.id, delivered);
    }

    final edeliveredResponse = await supabase
        .from('EDelivered')
        .select();
      
    for (var item in edeliveredResponse) {
      final edelivered = Edelivered.fromMap(item);
      await edeliveredBox.put(edelivered.id, edelivered);
    }

    final expenseResponse = await supabase
        .from('Expense')
        .select();
      
    for (var item in expenseResponse) {
      final expense = ExpenseModel.fromMap(item);
      await expenseBox.put(expense.id, expense);
    }

    final incomeResponse = await supabase
        .from('Income')
        .select();
      
    for (var item in incomeResponse) {
      final income = IncomeModel.fromMap(item);
      await incomeBox.put(income.id, income);
    }
    

    print("✅ Initial sync completed for admin $adminId");
  } catch (e) {
    print("❌ Initial sync failed: $e");
  }
}

Future<void> initialUserSync(String userId, String organizationId,String adminId) async {
  final customerBox = Hive.box<Customer>('Customer');
  final organizationBox = Hive.box<Organization>('Organization');
  final adminBox = Hive.box<Admin>('Admin');
  final deliveredBox = Hive.box<Delivered>('Delivered');
  final edeliveredBox = Hive.box<Edelivered>('Edelivered');

  try {
    // 1. Fetch Admin record
    final adminResponse = await supabase
        .from('Admin')
        .select()
        .eq('id', adminId)
        .single();

    final admin = Admin.fromMap(adminResponse);
    await adminBox.put(admin.id, admin);

    // 2. Fetch Organizations
    final orgResponse = await supabase
        .from('Organization')
        .select()
        .eq('id', organizationId).single();

   
      final org = Organization.fromMap(orgResponse);
      await organizationBox.put(org.id, org);

    // 3. Fetch Customers
    final custResponse = await supabase
        .from('Customer')
        .select()
        .eq('id', userId).single();

    
      final cust = Customer.fromMap(custResponse);
      await customerBox.put(cust.id, cust);
   

    final deliveredResponse = await supabase
        .from('Delivered')
        .select().eq('customerid', userId);
      
    for (var item in deliveredResponse) {
      final delivered = Delivered.fromMap(item);
      await deliveredBox.put(delivered.id, delivered);
    }

    final edeliveredResponse = await supabase
        .from('EDelivered')
        .select().eq('customerid', userId);
      
    for (var item in edeliveredResponse) {
      final edelivered = Edelivered.fromMap(item);
      await edeliveredBox.put(edelivered.id, edelivered);
    }

    print("✅ Initial sync completed for customer $adminId");
  } catch (e) {
    print("❌ Initial sync failed: $e");
  }
}
}
