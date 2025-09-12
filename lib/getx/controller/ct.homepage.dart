import 'dart:io';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:milklog/getx/services/s.homepage.dart';
import 'package:milklog/getx/services/s.sync.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:milklog/hive_model/organization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  final RxString name = ''.obs;
  final RxInt customerCount = 0.obs;
  final RxInt delivered = 0.obs;
  final HomePageService service = HomePageService();
  final SyncService syncService = SyncService();

  @override
  void onInit() {
    getRequiredData();
    super.onInit();
  }

  getRequiredData() {
    Admin admin = service.getAdminInfo();
    name.value = '${admin.firstName} ${admin.lastName}';
    customerCount.value = service.getCustomerCount();
    delivered.value = service.getDeliveredCount();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sync() async {
    await syncService.syncAdmin();
    await syncService.syncOrganization();
    await syncService.syncCustomer();
    await syncService.syncDelivered();
    await syncService.syncEdelivered();
    Get.snackbar('Success', 'Sync successfull');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await clearLocalData(); // Hive local data clear
    Get.offAllNamed('/login');
  }

  Future<void> clearLocalData() async {
    await Hive.box<Customer>('Customer').clear();
    await Hive.box<Organization>('Organization').clear();
    await Hive.box<Admin>('Admin').clear();
    await Hive.box<Delivered>('Delivered').clear();
    await Hive.box<Edelivered>('Edelivered').clear();
  }

  List<DateTime> getDatesBetween(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    for (
      var d = start;
      d.isBefore(end.add(const Duration(days: 1)));
      d = d.add(const Duration(days: 1))
    ) {
      dates.add(d);
    }
    return dates;
  }

  Future<void> generateMatrixReport(DateTime fromDate, DateTime toDate) async {
    final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
    final Box<Customer> customerBox = Hive.box<Customer>('Customer');

    var excel = Excel.createExcel();
    Sheet sheet = excel['Deliveries'];

    // ---------------- Header ----------------
    final dates = getDatesBetween(fromDate, toDate);

    final idToName = {
      for (var c in customerBox.values)
        c.id: '${c.firstName} ${c.middleName} ${c.lastName}',
    };

    final customers =
        deliveredBox.values.map((e) => e.customerId).toSet().toList();

    List<CellValue?> header = [TextCellValue('Customer Name')];
    header.addAll(
      dates.map((d) => TextCellValue("${d.day}-${d.month}-${d.year}")),
    );
    header.add(TextCellValue('Total'));
    sheet.appendRow(header);

    // Create a bold + centered style
    CellStyle headerStyle = CellStyle(
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
      backgroundColorHex: ExcelColor.fromHexString(
        "#D9E1F2",
      ), // light blue background
    );

    // Apply style to first row (row 0)
    for (int col = 0; col < header.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
      );
      cell.cellStyle = headerStyle;
    }

    // ---------------- Rows ----------------
    // for (var customer in customers) {
    //   final customerName = idToName[customer] ?? "Unknown";
    //   List<CellValue?> row = [TextCellValue(customerName)];
    //   int rowTotal = 0;

    //   for (var date in dates) {
    //     final delivered = deliveredBox.values.any((e) =>
    //         e.customerId == customer &&
    //         e.date.year == date.year &&
    //         e.date.month == date.month &&
    //         e.date.day == date.day);

    //     if (delivered) {
    //       row.add(TextCellValue("✔"));
    //       rowTotal++;
    //     } else {
    //       row.add(TextCellValue(""));
    //     }
    //   }

    //   row.add(IntCellValue(rowTotal));
    //   sheet.appendRow(row);

    // }

    for (var i = 0; i < customers.length; i++) {
      final customer = customers[i];
      final customerName = idToName[customer] ?? "Unknown";

      List<CellValue?> row = [TextCellValue(customerName)];
      int rowTotal = 0;

      for (var date in dates) {
        final delivered = deliveredBox.values.any(
          (e) =>
              e.customerId == customer &&
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        );

        if (delivered) {
          row.add(TextCellValue("✔"));
          rowTotal++;
        } else {
          row.add(TextCellValue(""));
        }
      }

      row.add(IntCellValue(rowTotal));
      sheet.appendRow(row);

      // ---------------- Style this row ----------------
      int rowIndex = i + 1; // +1 because header is at row 0

      // Alternate row colors (zebra style)
      String bgColor = (i % 2 == 0) ? "#FFFFFF" : "#F2F2F2";

      CellStyle rowStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        fontSize: 8,
        backgroundColorHex: ExcelColor.fromHexString(bgColor),
      );

      // Apply style to each cell of this row
      for (int col = 0; col < row.length; col++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
        );
        cell.cellStyle = rowStyle;
      }
    }

    // // ---------------- Column Totals ----------------
    // List<CellValue?> colTotals = [TextCellValue('Total')];
    // for (var date in dates) {
    //   int count = deliveredBox.values.where((e) =>
    //       e.date.year == date.year &&
    //       e.date.month == date.month &&
    //       e.date.day == date.day).length;
    //   colTotals.add(IntCellValue(count));
    // }
    // colTotals.add(TextCellValue(""));
    // sheet.appendRow(colTotals);

    // ---------------- Save File in Downloads ----------------
    if (await Permission.storage.request().isGranted) {
      final directory = Directory(
        '/storage/emulated/0/Download',
      ); // Downloads folder
      if (!await directory.exists()) await directory.create(recursive: true);
      String filePath =
          '${directory.path}/Delivery ${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}.xlsx';

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      print("✅ Matrix Excel saved at $filePath");

      // ---------------- Share File ----------------
      await Share.shareXFiles([
        XFile(filePath),
      ], text: "Here is the delivery report 📊");

      Get.snackbar('Success', 'Download Successfully');
    } else {
      print("❌ Storage permission denied");
    }
  }
}
