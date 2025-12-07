import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/hive_model/admin.dart';

class AExpenseService extends GetxService {
final Box<Admin> adminBox = Hive.box<Admin>('Admin');

  Admin? getAdminInfo() => adminBox.isNotEmpty ? adminBox.values.first : null;
}