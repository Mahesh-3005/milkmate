import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:milklog/hive_model/organization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncService extends GetxService {
  final supabase = Supabase.instance.client;
  final Box<Admin> adminBox = Hive.box<Admin>('Admin');
  final Box<Organization> organizationBox = Hive.box<Organization>(
    'Organization',
  );
  final Box<Customer> customerBox = Hive.box<Customer>('Customer');
  final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
  final Box<Edelivered> edeliveredBox = Hive.box<Edelivered>('Edelivered');

  Future<void> syncAdmin() async {
    final unsynced = adminBox.values.where((c) => c.isSynced == false).toList();

    for (var admin in unsynced) {
      try {
        // UPDATE existing record
        final response =
            await supabase
                .from('Admin')
                .update({
                  'firstname': admin.firstName,
                  'middlename': admin.middleName,
                  'lastname': admin.lastName,
                  'address': admin.address,
                })
                .eq('id', admin.id)
                .select();

        if (response.isNotEmpty) {
          admin.isSynced = true;
          await admin.save();
        }
      } catch (e) {
        print("Sync failed for ${admin.firstName}: $e");
      }
    }
  }

  Future<void> syncOrganization() async {
    final unsynced =
        organizationBox.values.where((c) => c.isSynced == false).toList();

    for (var organization in unsynced) {
      try {
        // UPDATE existing record
        final response =
            await supabase
                .from('Organization')
                .update({'name': organization.name, 'key': organization.key})
                .eq('id', organization.id)
                .select();

        if (response.isNotEmpty) {
          organization.isSynced = true;
          await organization.save();
        }
      } catch (e) {
        print("Sync failed for ${organization.name}: $e");
      }
    }
  }

  Future<void> syncCustomer() async {
    final unsynced =
        customerBox.values.where((c) => c.isSynced == false).toList();

    for (var customer in unsynced) {
      try {
        // UPDATE existing record
        final response =
            await supabase.from('Customer').upsert({
              'id': customer.id,
              'firstname': customer.firstName,
              'middlename': customer.middleName,
              'lastname': customer.lastName,
              'phone': customer.phone,
              'address': customer.address,
              'rate': customer.rate,
              'quantity': customer.quantity,
              'milk_type': customer.milkType,
              'delivery_time': customer.deliveryTime,
              'organization_id': customer.organizationId,
              'admin_id': customer.adminId,
              'is_deleted': customer.isDeleted,
              'updated_at': DateTime.now().toIso8601String(),
            }).select();

        try {
          final organization =
              await supabase
                  .from('Organization')
                  .select()
                  .eq('id', customer.organizationId)
                  .single();
          final response2 =
              await supabase.from('Appuser').upsert({
                'referenceid': customer.id,
                'phone': customer.phone,
                'password': organization['key'],
                'role': 'Customer',
                'is_deleted': customer.isDeleted,
                'updated_at': DateTime.now().toIso8601String(),
              }).select();
        } catch (e) {
          print("Sync failed for ${customer.id}: $e");
        }

        if (response.isNotEmpty) {
          customer.isSynced = true;
          await customer.save();
        }
      } catch (e) {
        print("Sync failed for ${customer.id}: $e");
      }
    }
  }

  Future<void> syncDelivered() async {
    final unsynced =
        deliveredBox.values.where((c) => c.isSynced == false).toList();

    for (var deliveries in unsynced) {
      try {
        // UPDATE existing record
        final response =
            await supabase
                .from('Delivered')
                .insert(deliveries.toMap())
                .select();

        if (response.isNotEmpty) {
          deliveries.isSynced = true;
          await deliveries.save();
        }
      } catch (e) {
        print("Sync failed for ${deliveries.id}: $e");
      }
    }
  }

  Future<void> syncEdelivered() async {
    final unsynced =
        edeliveredBox.values.where((c) => c.isSynced == false).toList();

    for (var edeliveries in unsynced) {
      try {
        // UPDATE existing record
        final response =
            await supabase
                .from('EDelivered')
                .insert(edeliveries.toMap())
                .select();

        if (response.isNotEmpty) {
          edeliveries.isSynced = true;
          await edeliveries.save();
        }
      } catch (e) {
        print("Sync failed for ${edeliveries.id}: $e");
      }
    }
  }
}

// Future<void> syncCustomers() async {
//   final unsynced = customerBox.values.where((c) => c.isSynced == false).toList();

//   for (var customer in unsynced) {
//     try {
//       if (customer.id == null) {
//         // INSERT new record
//         final response = await supabase.from('customers').insert({
//           'name': customer.name,
//           'phone': customer.phone,
//         }).select();

//         if (response.isNotEmpty) {
//           // Save Supabase id locally
//           customer.id = response.first['id'].toString();
//           customer.isSynced = true;
//           await customer.save();
//         }
//       } else {
//         // UPDATE existing record
//         final response = await supabase.from('customers').update({
//           'name': customer.name,
//           'phone': customer.phone,
//         }).eq('id', customer.id!).select();

//         if (response.isNotEmpty) {
//           customer.isSynced = true;
//           await customer.save();
//         }
//       }
//     } catch (e) {
//       print("Sync failed for ${customer.name}: $e");
//     }
//   }
// }
