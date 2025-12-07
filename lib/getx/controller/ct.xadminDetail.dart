import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/getx/services/s.xadmindetail.dart';
import 'package:milklog/hive_model/admin.dart';

/// Controller to load and expose Admin details for the admin-detail view.
class XAdminDetailController extends GetxController {
	final Rxn<Admin> admin = Rxn<Admin>();
  final service = XAdminDetailService();
  final organizatioName = ''.obs;

	@override
	void onInit() {
		super.onInit();
		_loadAdmin();
	}

	void _loadAdmin() {
		try {
			final box = Hive.box<Admin>('Admin');
			if (box.isEmpty) return;
			final a = box.values.firstWhere((e) => !e.isDeleted, orElse: () => box.values.first);
			admin.value = a;
      organizatioName.value =  service.getOrganizationName(a.organizationId);
		} catch (e) {
			// ignore: avoid_print
			print('Error loading admin: $e');
		}
	}

	String displayName() {
		final a = admin.value;
		if (a == null) return '';
		final parts = [a.firstName, a.middleName, a.lastName].where((s) => s.trim().isNotEmpty).toList();
		return parts.join(' ');
	}                           
}