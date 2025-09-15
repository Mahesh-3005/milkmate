import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class ABillController extends GetxController {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  Rx<DateTime> startDate = DateTime(2000, 1, 1).obs;
  Rx<DateTime> endDate = DateTime(2000, 1, 1).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
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

  Future<void> generatePdfReport(DateTime fromDate, DateTime toDate) async {
    final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
    final Box<Customer> customerBox = Hive.box<Customer>('Customer');

    final pdf = pw.Document();

    final dates = getDatesBetween(fromDate, toDate);

    final idToCustomer = {for (var c in customerBox.values) c.id: c};

    final customers =
        deliveredBox.values.map((e) => e.customerId).toSet().toList();

    // ---------------- Summary Table ----------------
    List<List<String>> summaryData = [];

    double grandTotalQuantity = 0;
    int grandTotalDeliveredDays = 0;
    double grandTotalPayable = 0;

    for (var customerId in customers) {
      final customer = idToCustomer[customerId];
      if (customer == null) continue;

      final qty = customer.quantity.toDouble();
      final rate = customer.rate.toDouble();

      int deliveredDays =
          deliveredBox.values
              .where(
                (e) =>
                    e.customerId == customerId &&
                    e.date.isAfter(
                      fromDate.subtract(const Duration(days: 1)),
                    ) &&
                    e.date.isBefore(toDate.add(const Duration(days: 1))),
              )
              .length;

      final payable = qty * rate * deliveredDays;

      grandTotalQuantity += qty * deliveredDays;
      grandTotalDeliveredDays += deliveredDays;
      grandTotalPayable += payable;

      summaryData.add([
        '${customer.firstName} ${customer.middleName} ${customer.lastName}',
        '${qty.toStringAsFixed(2)} L',
        'Rs ${rate.toStringAsFixed(2)}',
        '$deliveredDays',
        'Rs ${payable.toStringAsFixed(2)}',
      ]);
    }

    // ---------------- PDF Content ----------------
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build:
            (context) => [
              pw.Text(
                'Milk Delivery Report',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'From: ${fromDate.day}-${fromDate.month}-${fromDate.year} To: ${toDate.day}-${toDate.month}-${toDate.year}',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),

              // --- Summary Table ---
              pw.Text(
                'Customer Summary',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 5),
              pw.Table.fromTextArray(
                headers: [
                  'Customer Name',
                  'Quantity',
                  'Rate',
                  'Delivered Days',
                  'Payable',
                ],
                data: summaryData,
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
                headerDecoration: pw.BoxDecoration(color: PdfColors.blue300),
                cellAlignment: pw.Alignment.center,
                cellPadding: const pw.EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 2,
                ),
                oddRowDecoration: pw.BoxDecoration(color: PdfColors.grey200),
              ),
              pw.SizedBox(height: 10),

              // Grand Total
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Grand Total: Quantity ${grandTotalQuantity.toStringAsFixed(1)} L | '
                  'Delivered Days $grandTotalDeliveredDays | '
                  'Payable Rs.${grandTotalPayable.toStringAsFixed(2)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 20),

              // --- Daily Delivery Matrix ---
              pw.Text(
                'Daily Delivery Matrix',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 5),
              pw.Table.fromTextArray(
                // headers: ['Customer', ...dates.map((d) => '${d.day}-${d.month}').toList()],
                headers: ['Customer', ...dates.map((d) => '${d.day}').toList()],
                data: [
                  for (var customerId in customers)
                    [
                      '${idToCustomer[customerId]?.firstName ?? ''} '
                          // '${idToCustomer[customerId]?.middleName ?? ''} '
                          '${idToCustomer[customerId]?.lastName ?? ''}',
                      ...dates.map((date) {
                        final delivered = deliveredBox.values.any(
                          (e) =>
                              e.customerId == customerId &&
                              e.date.year == date.year &&
                              e.date.month == date.month &&
                              e.date.day == date.day,
                        );
                        return delivered ? 'Y' : '';
                      }).toList(),
                    ],
                ],
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
                headerDecoration: pw.BoxDecoration(color: PdfColors.blue300),
                cellAlignment: pw.Alignment.center,
                cellPadding: const pw.EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 2,
                ),
                oddRowDecoration: pw.BoxDecoration(color: PdfColors.grey100),
              ),
            ],
      ),
    );

    // ---------------- Save & Share PDF ----------------
    if (await Permission.storage.request().isGranted) {
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) await directory.create(recursive: true);

      final filePath =
          '${directory.path}/MilkDelivery_${fromDate.day}-${fromDate.month}-${fromDate.year}_to_${toDate.day}-${toDate.month}-${toDate.year}.pdf';

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      print('✅ PDF saved at $filePath');

      // Share the PDF
      await Share.shareXFiles(
        [XFile(filePath)],
        text:
            "📄 Milk Delivery Report (${fromDate.day}-${fromDate.month}-${fromDate.year} → ${toDate.day}-${toDate.month}-${toDate.year})",
      );
    } else {
      print('❌ Storage permission denied');
    }
  }

  Future<void> generateMatrixReport(DateTime fromDate, DateTime toDate) async {
    final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
    final Box<Customer> customerBox = Hive.box<Customer>('Customer');

    var excel = Excel.createExcel();
    Sheet sheet = excel['Deliveries'];

    // ---------------- Dates ----------------
    final dates = getDatesBetween(fromDate, toDate);

    // Map customerId -> Customer object
    final idToCustomer = {for (var c in customerBox.values) c.id: c};

    final customers =
        deliveredBox.values.map((e) => e.customerId).toSet().toList();

    // ---------------- Header ----------------
    List<CellValue?> header = [
      TextCellValue('Customer Name'),
      TextCellValue('Quantity (Litre)'),
      TextCellValue('Rate (₹)'),
      TextCellValue('Total Delivered Days'),
      TextCellValue('Payable (₹)'),
    ];

    header.addAll(
      dates.map((d) => TextCellValue("${d.day}-${d.month}-${d.year}")),
    );
    header.add(TextCellValue('Total Quantity (Litre)'));

    sheet.appendRow(header);

    // Style header
    CellStyle headerStyle = CellStyle(
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
      fontSize: 11,
      backgroundColorHex: ExcelColor.fromHexString("#D9E1F2"),
    );

    for (int col = 0; col < header.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
      );
      cell.cellStyle = headerStyle;
    }

    // ---------------- Data Rows ----------------
    int grandDeliveredDays = 0;
    double grandTotalPayable = 0;
    double grandTotalQuantity = 0;

    for (var i = 0; i < customers.length; i++) {
      final customerId = customers[i];
      final customer = idToCustomer[customerId];
      if (customer == null) continue;

      final customerName =
          '${customer.firstName} ${customer.middleName} ${customer.lastName}';
      double qty = customer.quantity.toDouble();
      double rate = customer.rate.toDouble();

      int deliveredDays = 0;

      for (var date in dates) {
        final delivered = deliveredBox.values.any(
          (e) =>
              e.customerId == customerId &&
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        );
        if (delivered) deliveredDays++;
      }

      double payableAmount = (qty * rate) * deliveredDays;
      double totalQuantity = qty * deliveredDays;

      grandDeliveredDays += deliveredDays;
      grandTotalPayable += payableAmount;
      grandTotalQuantity += totalQuantity;

      List<CellValue?> row = [
        TextCellValue(customerName),
        TextCellValue("${qty.toStringAsFixed(2)} L"),
        TextCellValue("₹${rate.toStringAsFixed(2)}"),
        IntCellValue(deliveredDays),
        TextCellValue("₹${payableAmount.toStringAsFixed(2)}"),
      ];

      for (var date in dates) {
        final delivered = deliveredBox.values.any(
          (e) =>
              e.customerId == customerId &&
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        );

        if (delivered) {
          row.add(TextCellValue("✔"));
        } else {
          row.add(TextCellValue(""));
        }
      }

      row.add(TextCellValue("${totalQuantity.toStringAsFixed(2)} L"));

      sheet.appendRow(row);

      // ---------------- Row Styling ----------------
      int rowIndex = i + 1; // +1 for header
      String bgColor = (i % 2 == 0) ? "#FFFFFF" : "#F2F2F2";

      for (int col = 0; col < row.length; col++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
        );

        cell.cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
          fontSize: 9,
          backgroundColorHex: ExcelColor.fromHexString(bgColor),
          bold:
              (col == 4 ||
                  col == row.length - 1), // bold Payable + Total Quantity
        );
      }
    }

    // ---------------- Grand Total Row ----------------
    List<CellValue?> totalRow = [
      TextCellValue("Grand Total"),
      TextCellValue(""),
      TextCellValue(""),
      IntCellValue(grandDeliveredDays),
      TextCellValue("₹${grandTotalPayable.toStringAsFixed(2)}"),
    ];

    for (var date in dates) {
      totalRow.add(TextCellValue(""));
    }

    totalRow.add(TextCellValue("${grandTotalQuantity.toStringAsFixed(2)} L"));
    sheet.appendRow(totalRow);

    // Style total row
    int totalRowIndex = customers.length + 1;
    for (int col = 0; col < totalRow.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: totalRowIndex),
      );
      cell.cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        backgroundColorHex: ExcelColor.fromHexString("#FFD966"), // light yellow
      );
    }

    // ---------------- Save File ----------------
    if (await Permission.storage.request().isGranted) {
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) await directory.create(recursive: true);

      String filePath =
          '${directory.path}/Delivery_${fromDate.day}-${fromDate.month}-${fromDate.year}_to_${toDate.day}-${toDate.month}-${toDate.year}.xlsx';

      final encoded = excel.encode();
      if (encoded == null) {
        print("ERROR: excel.encode() returned null");
        return;
      }

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(encoded);

      print("✅ Matrix Excel saved at $filePath");

      await Share.shareXFiles(
        [XFile(filePath)],
        text:
            "📊 Milk Delivery Report (${fromDate.day}-${fromDate.month}-${fromDate.year} → ${toDate.day}-${toDate.month}-${toDate.year})",
      );

      Get.snackbar('Success', 'Report Downloaded & Ready to Share');
    } else {
      print("❌ Storage permission denied");
      Get.snackbar('Error', 'Storage permission denied');
    }
  }

  // Future<void> generateMatrixReport(DateTime fromDate, DateTime toDate) async {
  //   final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
  //   final Box<Customer> customerBox = Hive.box<Customer>('Customer');

  //   var excel = Excel.createExcel();
  //   Sheet sheet = excel['Deliveries'];

  //   // ---------------- Dates ----------------
  //   final dates = getDatesBetween(fromDate, toDate);

  //   // Map customerId -> Customer object
  //   final idToCustomer = {
  //     for (var c in customerBox.values) c.id: c,
  //   };

  //   final customers = deliveredBox.values.map((e) => e.customerId).toSet().toList();

  //   // ---------------- Header ----------------
  //   List<CellValue?> header = [
  //     TextCellValue('Customer Name'),
  //     TextCellValue('Quantity'),
  //     TextCellValue('Rate'),
  //     TextCellValue('Total Delivered Days'),
  //     TextCellValue('Payable'),
  //   ];

  //   header.addAll(
  //     dates.map((d) => TextCellValue("${d.day}-${d.month}-${d.year}")),
  //   );

  //   header.add(TextCellValue('Total Quantity'));

  //   sheet.appendRow(header);

  //   // Style header
  //   CellStyle headerStyle = CellStyle(
  //     bold: true,
  //     horizontalAlign: HorizontalAlign.Center,
  //     verticalAlign: VerticalAlign.Center,
  //     fontSize: 11,
  //     backgroundColorHex: ExcelColor.fromHexString("#D9E1F2"),
  //   );

  //   for (int col = 0; col < header.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
  //     );
  //     cell.cellStyle = headerStyle;
  //   }

  //   // ---------------- Data Rows ----------------
  //   int grandDeliveredDays = 0;
  //   double grandTotalPayable = 0;
  //   double grandTotalQuantity = 0;

  //   for (var i = 0; i < customers.length; i++) {
  //     final customerId = customers[i];
  //     final customer = idToCustomer[customerId];
  //     if (customer == null) continue;

  //     final customerName =
  //         '${customer.firstName} ${customer.middleName} ${customer.lastName}';
  //     double qty = customer.quantity.toDouble();
  //     double rate = customer.rate.toDouble();

  //     int deliveredDays = 0;

  //     for (var date in dates) {
  //       final delivered = deliveredBox.values.any(
  //         (e) =>
  //             e.customerId == customerId &&
  //             e.date.year == date.year &&
  //             e.date.month == date.month &&
  //             e.date.day == date.day,
  //       );

  //       if (delivered) deliveredDays++;
  //     }

  //     double payableAmount = (qty * rate) * deliveredDays;
  //     double totalQuantity = qty * deliveredDays;

  //     grandDeliveredDays += deliveredDays;
  //     grandTotalPayable += payableAmount;
  //     grandTotalQuantity += totalQuantity;

  //     List<CellValue?> row = [
  //       TextCellValue(customerName),
  //       DoubleCellValue(qty),
  //       DoubleCellValue(rate),
  //       IntCellValue(deliveredDays),
  //       DoubleCellValue(payableAmount),
  //     ];

  //     for (var date in dates) {
  //       final delivered = deliveredBox.values.any(
  //         (e) =>
  //             e.customerId == customerId &&
  //             e.date.year == date.year &&
  //             e.date.month == date.month &&
  //             e.date.day == date.day,
  //       );

  //       if (delivered) {
  //         row.add(TextCellValue("✔"));
  //       } else {
  //         row.add(TextCellValue(""));
  //       }
  //     }

  //     row.add(DoubleCellValue(totalQuantity));

  //     sheet.appendRow(row);

  //     // ---------------- Row Styling ----------------
  //     int rowIndex = i + 1; // +1 for header
  //     String bgColor = (i % 2 == 0) ? "#FFFFFF" : "#F2F2F2";

  //     for (int col = 0; col < row.length; col++) {
  //       final cell = sheet.cell(
  //         CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
  //       );

  //       cell.cellStyle = CellStyle(
  //         horizontalAlign: HorizontalAlign.Center,
  //         verticalAlign: VerticalAlign.Center,
  //         fontSize: 9,
  //         backgroundColorHex: ExcelColor.fromHexString(bgColor),
  //         bold: (col == 4 || col == row.length - 1), // bold Payable + Total Quantity
  //       );
  //     }
  //   }

  //   // ---------------- Grand Total Row ----------------
  //   List<CellValue?> totalRow = [
  //     TextCellValue("Grand Total"),
  //     TextCellValue(""),
  //     TextCellValue(""),
  //     IntCellValue(grandDeliveredDays),
  //     DoubleCellValue(grandTotalPayable),
  //   ];

  //   for (var date in dates) {
  //     totalRow.add(TextCellValue(""));
  //   }

  //   totalRow.add(DoubleCellValue(grandTotalQuantity));
  //   sheet.appendRow(totalRow);

  //   // Style total row
  //   int totalRowIndex = customers.length + 1;
  //   for (int col = 0; col < totalRow.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: totalRowIndex),
  //     );
  //     cell.cellStyle = CellStyle(
  //       bold: true,
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //       backgroundColorHex: ExcelColor.fromHexString("#FFD966"), // light yellow
  //     );
  //   }

  //   // ---------------- Save File ----------------
  //   if (await Permission.storage.request().isGranted) {
  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) await directory.create(recursive: true);

  //     String filePath =
  //         '${directory.path}/Delivery_${fromDate.day}-${fromDate.month}-${fromDate.year}_to_${toDate.day}-${toDate.month}-${toDate.year}.xlsx';

  //     final encoded = excel.encode();
  //     if (encoded == null) {
  //       print("ERROR: excel.encode() returned null");
  //       return;
  //     }

  //     File(filePath)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(encoded);

  //     print("✅ Matrix Excel saved at $filePath");

  //     await Share.shareXFiles([XFile(filePath)],
  //         text:
  //             "📊 Milk Delivery Report (${fromDate.day}-${fromDate.month}-${fromDate.year} → ${toDate.day}-${toDate.month}-${toDate.year})");

  //     Get.snackbar('Success', 'Report Downloaded & Ready to Share');
  //   } else {
  //     print("❌ Storage permission denied");
  //     Get.snackbar('Error', 'Storage permission denied');
  //   }
  // }

  //   Future<void> generateMatrixReport(DateTime fromDate, DateTime toDate) async {
  //   final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
  //   final Box<Customer> customerBox = Hive.box<Customer>('Customer');

  //   var excel = Excel.createExcel();
  //   Sheet sheet = excel['Deliveries'];

  //   // ---------------- Dates ----------------
  //   final dates = getDatesBetween(fromDate, toDate);

  //   // Map customerId -> Customer object
  //   final idToCustomer = {
  //     for (var c in customerBox.values) c.id: c,
  //   };

  //   final customers = deliveredBox.values.map((e) => e.customerId).toSet().toList();

  //   // ---------------- Header ----------------
  //   List<CellValue?> header = [
  //     TextCellValue('Customer Name'),
  //     TextCellValue('Quantity'),
  //     TextCellValue('Rate'),
  //     TextCellValue('Total Delivered Days'),
  //     TextCellValue('Payable'),
  //   ];

  //   header.addAll(
  //     dates.map((d) => TextCellValue("${d.day}-${d.month}-${d.year}")),
  //   );

  //   sheet.appendRow(header);

  //   // Style header
  //   CellStyle headerStyle = CellStyle(
  //     bold: true,
  //     horizontalAlign: HorizontalAlign.Center,
  //     verticalAlign: VerticalAlign.Center,
  //     fontSize: 11,
  //     backgroundColorHex: ExcelColor.fromHexString("#D9E1F2"),
  //   );

  //   for (int col = 0; col < header.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
  //     );
  //     cell.cellStyle = headerStyle;
  //   }

  //   // ---------------- Data Rows ----------------
  //   int grandDeliveredDays = 0;
  //   double grandTotalPayable = 0;

  //   for (var i = 0; i < customers.length; i++) {
  //     final customerId = customers[i];
  //     final customer = idToCustomer[customerId];
  //     if (customer == null) continue;

  //     final customerName =
  //         '${customer.firstName} ${customer.middleName} ${customer.lastName}';
  //     double qty = customer.quantity.toDouble();
  //     double rate = customer.rate.toDouble();

  //     int deliveredDays = 0;

  //     for (var date in dates) {
  //       final delivered = deliveredBox.values.any(
  //         (e) =>
  //             e.customerId == customerId &&
  //             e.date.year == date.year &&
  //             e.date.month == date.month &&
  //             e.date.day == date.day,
  //       );

  //       if (delivered) deliveredDays++;
  //     }

  //     double payableAmount = (qty * rate) * deliveredDays;
  //     grandDeliveredDays += deliveredDays;
  //     grandTotalPayable += payableAmount;

  //     List<CellValue?> row = [
  //       TextCellValue(customerName),
  //       DoubleCellValue(qty),
  //       DoubleCellValue(rate),
  //       IntCellValue(deliveredDays),
  //       DoubleCellValue(payableAmount),
  //     ];

  //     for (var date in dates) {
  //       final delivered = deliveredBox.values.any(
  //         (e) =>
  //             e.customerId == customerId &&
  //             e.date.year == date.year &&
  //             e.date.month == date.month &&
  //             e.date.day == date.day,
  //       );

  //       if (delivered) {
  //         row.add(TextCellValue("✔"));
  //       } else {
  //         row.add(TextCellValue(""));
  //       }
  //     }

  //     sheet.appendRow(row);

  //     // ---------------- Row Styling ----------------
  //     int rowIndex = i + 1; // +1 for header
  //     String bgColor = (i % 2 == 0) ? "#FFFFFF" : "#F2F2F2";

  //     for (int col = 0; col < row.length; col++) {
  //       final cell = sheet.cell(
  //         CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
  //       );

  //       cell.cellStyle = CellStyle(
  //         horizontalAlign: HorizontalAlign.Center,
  //         verticalAlign: VerticalAlign.Center,
  //         fontSize: 9,
  //         backgroundColorHex: ExcelColor.fromHexString(bgColor),
  //         bold: (col == 4), // Bold only Payable column
  //       );
  //     }
  //   }

  //   // ---------------- Grand Total Row ----------------
  //   List<CellValue?> totalRow = [
  //     TextCellValue("Grand Total"),
  //     TextCellValue(""),
  //     TextCellValue(""),
  //     IntCellValue(grandDeliveredDays),
  //     DoubleCellValue(grandTotalPayable),
  //   ];

  //   for (var date in dates) {
  //     totalRow.add(TextCellValue(""));
  //   }

  //   sheet.appendRow(totalRow);

  //   // Style total row
  //   int totalRowIndex = customers.length + 1;
  //   for (int col = 0; col < totalRow.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: totalRowIndex),
  //     );
  //     cell.cellStyle = CellStyle(
  //       bold: true,
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //       backgroundColorHex: ExcelColor.fromHexString("#FFD966"), // light yellow
  //     );
  //   }

  //   // ---------------- Save File ----------------
  //   if (await Permission.storage.request().isGranted) {
  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) await directory.create(recursive: true);

  //     String filePath =
  //         '${directory.path}/Delivery_${fromDate.day}-${fromDate.month}-${fromDate.year}_to_${toDate.day}-${toDate.month}-${toDate.year}.xlsx';

  //     final encoded = excel.encode();
  //     if (encoded == null) {
  //       print("ERROR: excel.encode() returned null");
  //       return;
  //     }

  //     File(filePath)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(encoded);

  //     print("✅ Matrix Excel saved at $filePath");

  //     await Share.shareXFiles([XFile(filePath)],
  //         text:
  //             "📊 Milk Delivery Report (${fromDate.day}-${fromDate.month}-${fromDate.year} → ${toDate.day}-${toDate.month}-${toDate.year})");

  //     Get.snackbar('Success', 'Report Downloaded & Ready to Share');
  //   } else {
  //     print("❌ Storage permission denied");
  //     Get.snackbar('Error', 'Storage permission denied');
  //   }
  // }

  //   Future<void> generateMatrixReport(DateTime fromDate, DateTime toDate) async {
  //   final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
  //   final Box<Customer> customerBox = Hive.box<Customer>('Customer');

  //   var excel = Excel.createExcel();
  //   Sheet sheet = excel['Deliveries'];

  //   // ---------------- Dates ----------------
  //   final dates = getDatesBetween(fromDate, toDate);

  //   // Map customerId -> Customer object
  //   final idToCustomer = {
  //     for (var c in customerBox.values) c.id: c,
  //   };

  //   final customers = deliveredBox.values.map((e) => e.customerId).toSet().toList();

  //   // ---------------- Header ----------------
  //   List<CellValue?> header = [
  //     TextCellValue('Customer Name'),
  //     TextCellValue('Quantity'),
  //     TextCellValue('Rate'),
  //     TextCellValue('Amount/Day'),
  //   ];

  //   header.addAll(
  //     dates.map((d) => TextCellValue("${d.day}-${d.month}-${d.year}")),
  //   );

  //   header.add(TextCellValue('Total Delivered Days'));
  //   header.add(TextCellValue('Payable'));

  //   sheet.appendRow(header);

  //   // Style header
  //   CellStyle headerStyle = CellStyle(
  //     bold: true,
  //     horizontalAlign: HorizontalAlign.Center,
  //     verticalAlign: VerticalAlign.Center,
  //     fontSize: 11,
  //     backgroundColorHex: ExcelColor.fromHexString("#D9E1F2"),
  //   );

  //   for (int col = 0; col < header.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
  //     );
  //     cell.cellStyle = headerStyle;
  //   }

  //   // ---------------- Data Rows ----------------
  //   int grandDeliveredDays = 0;
  //   double grandTotalPayable = 0;

  //   for (var i = 0; i < customers.length; i++) {
  //     final customerId = customers[i];
  //     final customer = idToCustomer[customerId];
  //     if (customer == null) continue;

  //     final customerName =
  //         '${customer.firstName} ${customer.middleName} ${customer.lastName}';
  //     double qty = customer.quantity.toDouble();
  //     double rate = customer.rate.toDouble();

  //     List<CellValue?> row = [
  //       TextCellValue(customerName),
  //       DoubleCellValue(qty),
  //       DoubleCellValue(rate),
  //       DoubleCellValue(qty * rate), // amount/day
  //     ];

  //     int deliveredDays = 0;

  //     for (var date in dates) {
  //       final delivered = deliveredBox.values.any(
  //         (e) =>
  //             e.customerId == customerId &&
  //             e.date.year == date.year &&
  //             e.date.month == date.month &&
  //             e.date.day == date.day,
  //       );

  //       if (delivered) {
  //         row.add(TextCellValue("✔"));
  //         deliveredDays++;
  //       } else {
  //         row.add(TextCellValue(""));
  //       }
  //     }

  //     double payableAmount = (qty * rate) * deliveredDays;
  //     grandDeliveredDays += deliveredDays;
  //     grandTotalPayable += payableAmount;

  //     row.add(IntCellValue(deliveredDays));
  //     row.add(DoubleCellValue(payableAmount));
  //     sheet.appendRow(row);

  //     // ---------------- Row Styling ----------------
  //     int rowIndex = i + 1; // +1 for header
  //     String bgColor = (i % 2 == 0) ? "#FFFFFF" : "#F2F2F2";

  //     for (int col = 0; col < row.length; col++) {
  //       final cell = sheet.cell(
  //         CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
  //       );

  //       cell.cellStyle = CellStyle(
  //         horizontalAlign: HorizontalAlign.Center,
  //         verticalAlign: VerticalAlign.Center,
  //         fontSize: 9,
  //         backgroundColorHex: ExcelColor.fromHexString(bgColor),
  //         bold: (col == row.length - 1), // bold payable amount only
  //       );
  //     }
  //   }

  //   // ---------------- Grand Total Row ----------------
  //   List<CellValue?> totalRow = [
  //     TextCellValue("Grand Total"),
  //     TextCellValue(""),
  //     TextCellValue(""),
  //     TextCellValue(""),
  //   ];

  //   for (var date in dates) {
  //     totalRow.add(TextCellValue(""));
  //   }

  //   totalRow.add(IntCellValue(grandDeliveredDays));
  //   totalRow.add(DoubleCellValue(grandTotalPayable));
  //   sheet.appendRow(totalRow);

  //   // Style total row
  //   int totalRowIndex = customers.length + 1;
  //   for (int col = 0; col < totalRow.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: totalRowIndex),
  //     );
  //     cell.cellStyle = CellStyle(
  //       bold: true,
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //       backgroundColorHex: ExcelColor.fromHexString("#FFD966"), // light yellow
  //     );
  //   }

  //   // ---------------- Save File ----------------
  //   if (await Permission.storage.request().isGranted) {
  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) await directory.create(recursive: true);

  //     String filePath =
  //         '${directory.path}/Delivery_${fromDate.day}-${fromDate.month}-${fromDate.year}_to_${toDate.day}-${toDate.month}-${toDate.year}.xlsx';

  //     final encoded = excel.encode();
  //     if (encoded == null) {
  //       print("ERROR: excel.encode() returned null");
  //       return;
  //     }

  //     File(filePath)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(encoded);

  //     print("✅ Matrix Excel saved at $filePath");

  //     // Share to WhatsApp / other apps
  //     await Share.shareXFiles([XFile(filePath)],
  //         text:
  //             "📊 Milk Delivery Report (${fromDate.day}-${fromDate.month}-${fromDate.year} → ${toDate.day}-${toDate.month}-${toDate.year})");

  //     Get.snackbar('Success', 'Report Downloaded & Ready to Share');
  //   } else {
  //     print("❌ Storage permission denied");
  //     Get.snackbar('Error', 'Storage permission denied');
  //   }
  // }

  //   Future<void> generateMatrixReport(DateTime fromDate, DateTime toDate) async {
  //   final Box<Delivered> deliveredBox = Hive.box<Delivered>('Delivered');
  //   final Box<Customer> customerBox = Hive.box<Customer>('Customer');

  //   var excel = Excel.createExcel();
  //   Sheet sheet = excel['Deliveries'];

  //   // ---------------- Dates ----------------
  //   final dates = getDatesBetween(fromDate, toDate);

  //   // Map customerId -> Customer object
  //   final idToCustomer = {
  //     for (var c in customerBox.values) c.id: c,
  //   };

  //   final customers = deliveredBox.values.map((e) => e.customerId).toSet().toList();

  //   // ---------------- Header ----------------
  //   List<CellValue?> header = [
  //     TextCellValue('Customer Name'),
  //     TextCellValue('Quantity'),
  //     TextCellValue('Rate'),
  //     TextCellValue('Amount/Day'),
  //   ];

  //   header.addAll(
  //     dates.map((d) => TextCellValue("${d.day}-${d.month}-${d.year}")),
  //   );

  //   header.add(TextCellValue('Total Delivered Days'));
  //   header.add(TextCellValue('Payable'));

  //   sheet.appendRow(header);

  //   // Style header
  //   CellStyle headerStyle = CellStyle(
  //     bold: true,
  //     horizontalAlign: HorizontalAlign.Center,
  //     verticalAlign: VerticalAlign.Center,
  //     backgroundColorHex: ExcelColor.fromHexString("#D9E1F2"),
  //   );

  //   for (int col = 0; col < header.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
  //     );
  //     cell.cellStyle = headerStyle;
  //   }

  //   // ---------------- Data Rows ----------------
  //   int grandDeliveredDays = 0;
  //   double grandTotalPayable = 0;

  //   for (var i = 0; i < customers.length; i++) {
  //     final customerId = customers[i];
  //     final customer = idToCustomer[customerId];
  //     if (customer == null) continue;

  //     final customerName =
  //         '${customer.firstName} ${customer.middleName} ${customer.lastName}';
  //     double qty = customer.quantity;
  //     double rate = customer.rate;

  //     List<CellValue?> row = [
  //       TextCellValue(customerName),
  //       DoubleCellValue(qty),
  //       DoubleCellValue(rate),
  //       DoubleCellValue(qty * rate), // amount/day
  //     ];

  //     int deliveredDays = 0;

  //     for (var date in dates) {
  //       final delivered = deliveredBox.values.any(
  //         (e) =>
  //             e.customerId == customerId &&
  //             e.date.year == date.year &&
  //             e.date.month == date.month &&
  //             e.date.day == date.day,
  //       );

  //       if (delivered) {
  //         row.add(TextCellValue("✔"));
  //         deliveredDays++;
  //       } else {
  //         row.add(TextCellValue(""));
  //       }
  //     }

  //     double payableAmount = (qty * rate) * deliveredDays;
  //     grandDeliveredDays += deliveredDays;
  //     grandTotalPayable += payableAmount;

  //     row.add(IntCellValue(deliveredDays));
  //     row.add(DoubleCellValue(payableAmount));
  //     sheet.appendRow(row);

  //     // ---------------- Row Styling ----------------
  //     int rowIndex = i + 1; // +1 for header
  //     String bgColor = (i % 2 == 0) ? "#FFFFFF" : "#F2F2F2";

  //     CellStyle rowStyle = CellStyle(
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //       fontSize: 9,
  //       backgroundColorHex: ExcelColor.fromHexString(bgColor),
  //     );

  //     for (int col = 0; col < row.length; col++) {
  //       final cell = sheet.cell(
  //         CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
  //       );
  //       cell.cellStyle = rowStyle;

  //       // Bold only Payable Amount column
  //       if (col == row.length - 1) {
  //         cell.cellStyle = CellStyle(
  //           bold: true,
  //           horizontalAlign: HorizontalAlign.Center,
  //           verticalAlign: VerticalAlign.Center,
  //           fontSize: 9,
  //           backgroundColorHex: ExcelColor.fromHexString(bgColor),
  //         );
  //       }
  //     }
  //   }

  //   // ---------------- Grand Total Row ----------------
  //   List<CellValue?> totalRow = [
  //     TextCellValue("Grand Total"),
  //     TextCellValue(""),
  //     TextCellValue(""),
  //     TextCellValue(""),
  //   ];

  //   for (var date in dates) {
  //     totalRow.add(TextCellValue(""));
  //   }

  //   totalRow.add(IntCellValue(grandDeliveredDays));
  //   totalRow.add(DoubleCellValue(grandTotalPayable));
  //   sheet.appendRow(totalRow);

  //   // Style total row
  //   int totalRowIndex = customers.length + 1;
  //   for (int col = 0; col < totalRow.length; col++) {
  //     final cell = sheet.cell(
  //       CellIndex.indexByColumnRow(columnIndex: col, rowIndex: totalRowIndex),
  //     );
  //     cell.cellStyle = CellStyle(
  //       bold: true,
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //       backgroundColorHex: ExcelColor.fromHexString("#FFD966"), // light yellow
  //     );
  //   }

  //   // ---------------- Save File ----------------
  //   if (await Permission.storage.request().isGranted) {
  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) await directory.create(recursive: true);
  //     String filePath =
  //         '${directory.path}/Delivery_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}.xlsx';

  //     File(filePath)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(excel.encode()!);

  //     print("✅ Matrix Excel saved at $filePath");

  //     await Share.shareXFiles([XFile(filePath)],
  //         text: "Here is the delivery report 📊");

  //     Get.snackbar('Success', 'Download Successfully');
  //   } else {
  //     print("❌ Storage permission denied");
  //   }
  // }

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // current date
      firstDate: DateTime(2025), // minimum date
      lastDate: DateTime(2040), // maximum date
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      startDateController.text = formattedDate;
      startDate.value = pickedDate;
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // current date
      firstDate: DateTime(2025), // minimum date
      lastDate: DateTime(2040), // maximum date
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      endDateController.text = formattedDate;
      endDate.value = pickedDate;
    }
  }
}
