import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:path_provider/path_provider.dart';
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

// Make sure to import your Hive models:
// import 'models/customer.dart';
// import 'models/edelivered.dart';

Future<void> exportDecoratedDeliveriesExcel(
  DateTime startDate,
  DateTime endDate,
) async {
  final Box<Edelivered> deliveredBox = Hive.box<Edelivered>('Edelivered');
  final Box<Customer> customerBox = Hive.box<Customer>('customer');

  // 1️⃣ Filter deliveries by date range
  final filteredDeliveries = deliveredBox.values.where((delivery) {
    final d = delivery.date;
    return d.isAfter(startDate.subtract(const Duration(days: 1))) &&
        d.isBefore(endDate.add(const Duration(days: 1)));
  }).toList();

  if (filteredDeliveries.isEmpty) {
    Get.snackbar('No Data', 'No deliveries found in this range.');
    return;
  }

  // 2️⃣ Sort deliveries
  filteredDeliveries.sort((a, b) {
    int idCompare = a.customerId.compareTo(b.customerId);
    if (idCompare != 0) return idCompare;
    return a.date.compareTo(b.date);
  });

  // 3️⃣ Create Excel & Sheet
  final excel = Excel.createExcel();
  final sheet = excel['Milk Deliveries'];
  excel.delete('Sheet1'); // remove default sheet

  // 4️⃣ Define styles (remove unsupported 'borderMode' usage)
  final headerStyle = CellStyle(
    bold: true,
    fontSize: 13,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    backgroundColorHex: ExcelColor.fromHexString("#D1C4E9"), // soft purple
  );

  final boldStyle = CellStyle(
    bold: true,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    backgroundColorHex: ExcelColor.fromHexString("#EDE7F6"),
  );

  final normalStyle = CellStyle(
    horizontalAlign: HorizontalAlign.Center,
  );

  // 5️⃣ Add header row
  final headers = [
    'Customer Name',
    'Date',
    'Quantity (L)',
    'Rate (₹/L)',
    'Total (₹)',
  ];

  sheet.appendRow(headers.map((e) => TextCellValue(e)).toList());

  for (int i = 0; i < headers.length; i++) {
    final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
    cell.cellStyle = headerStyle;
  }

  // 6️⃣ Data population with subtotals
  String? currentCustomerId;
  double subtotalQty = 0.0;
  double subtotalAmt = 0.0;
  double grandQty = 0.0;
  double grandAmt = 0.0;
  int currentRow = 1;

  for (var delivery in filteredDeliveries) {
    if (currentCustomerId != null && currentCustomerId != delivery.customerId) {
      // Subtotal row
      sheet.appendRow([
        TextCellValue('Subtotal'),
        TextCellValue(''),
        TextCellValue(subtotalQty.toStringAsFixed(2)),
        TextCellValue(''),
        TextCellValue(subtotalAmt.toStringAsFixed(2)),
      ]);

      for (int i = 0; i < 5; i++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow))
            .cellStyle = boldStyle;
      }
      currentRow++;

      subtotalQty = 0.0;
      subtotalAmt = 0.0;
    }

  currentCustomerId = delivery.customerId;

  final customer = customerBox.values.firstWhereOrNull((c) => c.id == delivery.customerId);
    final name = customer != null ? '${customer.firstName} ${customer.lastName}' : 'Unknown';
    final rate = customer?.rate ?? 0.0;
    final total = delivery.quantity * rate;

    // Add row
    sheet.appendRow([
      TextCellValue(name),
      TextCellValue('${delivery.date.day}-${delivery.date.month}-${delivery.date.year}'),
      TextCellValue(delivery.quantity.toStringAsFixed(2)),
      TextCellValue(rate.toStringAsFixed(2)),
      TextCellValue(total.toStringAsFixed(2)),
    ]);

    for (int i = 0; i < 5; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow))
          .cellStyle = normalStyle;
    }

    subtotalQty += delivery.quantity;
    subtotalAmt += total;
    grandQty += delivery.quantity;
    grandAmt += total;
    currentRow++;
  }

  // Add last customer's subtotal
  sheet.appendRow([
    TextCellValue('Subtotal'),
    TextCellValue(''),
    TextCellValue(subtotalQty.toStringAsFixed(2)),
    TextCellValue(''),
    TextCellValue(subtotalAmt.toStringAsFixed(2)),
  ]);
  for (int i = 0; i < 5; i++) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow))
        .cellStyle = boldStyle;
  }
  currentRow++;

  // 7️⃣ Add grand total
  sheet.appendRow([
    TextCellValue('GRAND TOTAL'),
    TextCellValue(''),
    TextCellValue(grandQty.toStringAsFixed(2)),
    TextCellValue(''),
    TextCellValue(grandAmt.toStringAsFixed(2)),
  ]);

    for (int i = 0; i < 5; i++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow))
            .cellStyle = CellStyle(
      bold: true,
      backgroundColorHex: ExcelColor.fromHexString("#C5CAE9"),
      horizontalAlign: HorizontalAlign.Center,
    );
  }

  // 8️⃣ Adjust column width
  // Note: `setColAutoFit` may not be supported in the excel package version used here.
  // If you need column auto-fit, consider computing widths manually or upgrading the package.

  // 9️⃣ Save file
  final dir = await getApplicationDocumentsDirectory();
  final filePath =
      '${dir.path}/ExtraDelivered_milk_report_${startDate.day}/${startDate.month}/${startDate.year}_${endDate.day}/${endDate.month}/${endDate.year}.xlsx';

  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  // 🔟 Share or show success
  try {
    await Share.shareXFiles([XFile(filePath)],
        text:
            '📊 Milk Delivery Report (${startDate.day}-${startDate.month}-${startDate.year} → ${endDate.day}-${endDate.month}-${endDate.year})');
    Get.snackbar('Success', 'Excel report generated & shared!');
  } catch (e) {
    print('❌ Error sharing file: $e');
    Get.snackbar('Error', 'Could not share file');
  }
}

Future<void> exportDeliveriesPDF(DateTime startDate, DateTime endDate) async {
  final Box<Edelivered> deliveredBox = Hive.box<Edelivered>('Edelivered');
  final Box<Customer> customerBox = Hive.box<Customer>('customer');

  // 1️⃣ Filter deliveries by date range
  final filteredDeliveries = deliveredBox.values.where((delivery) {
    final d = delivery.date;
    return d.isAfter(startDate.subtract(const Duration(days: 1))) &&
        d.isBefore(endDate.add(const Duration(days: 1)));
  }).toList();

  if (filteredDeliveries.isEmpty) {
    Get.snackbar('No Data', 'No deliveries found in this range.');
    return;
  }

  // 2️⃣ Sort deliveries by customer and date
  filteredDeliveries.sort((a, b) {
    int idCompare = a.customerId.compareTo(b.customerId);
    if (idCompare != 0) return idCompare;
    return a.date.compareTo(b.date);
  });

  // 3️⃣ Create PDF document
  final pdf = pw.Document();

  final tableHeaders = [
    'Customer Name',
    'Date',
    'Quantity (L)',
    'Rate (Rs/L)',
    'Total (Rs)',
  ];

  // 4️⃣ Prepare table data
  String? currentCustomerId;
  double subtotalQty = 0;
  double subtotalAmt = 0;
  double grandQty = 0;
  double grandAmt = 0;

  final List<List<String>> tableData = [];
  final List<int> subtotalRows = [];
  int grandTotalRowIndex = -1;

  // For summary
  final Map<String, Map<String, dynamic>> customerSummary = {};

  for (var delivery in filteredDeliveries) {
    if (currentCustomerId != null && currentCustomerId != delivery.customerId) {
      // Add subtotal row
      tableData.add([
        'Subtotal',
        '',
        subtotalQty.toStringAsFixed(2),
        '',
        subtotalAmt.toStringAsFixed(2),
      ]);
      subtotalRows.add(tableData.length - 1);
      subtotalQty = 0;
      subtotalAmt = 0;
    }

    currentCustomerId = delivery.customerId;

    final customer = customerBox.values.firstWhereOrNull(
      (c) => c.id == delivery.customerId,
    );

    final name =
        customer != null ? '${customer.firstName} ${customer.lastName}' : 'Unknown';
    final rate = customer?.rate ?? 0.0;
    final total = delivery.quantity * rate;

    tableData.add([
      name,
      '${delivery.date.day}-${delivery.date.month}-${delivery.date.year}',
      delivery.quantity.toStringAsFixed(2),
      rate.toStringAsFixed(2),
      total.toStringAsFixed(2),
    ]);

    // Totals
    subtotalQty += delivery.quantity;
    subtotalAmt += total;
    grandQty += delivery.quantity;
    grandAmt += total;

    // Summary per customer
    if (!customerSummary.containsKey(name)) {
      customerSummary[name] = {'qty': 0.0, 'amt': 0.0};
    }
    customerSummary[name]!['qty'] += delivery.quantity;
    customerSummary[name]!['amt'] += total;
  }

  // Add final subtotal
  tableData.add([
    'Subtotal',
    '',
    subtotalQty.toStringAsFixed(2),
    '',
    subtotalAmt.toStringAsFixed(2),
  ]);
  subtotalRows.add(tableData.length - 1);

  // Add grand total row
  tableData.add([
    'GRAND TOTAL',
    '',
    grandQty.toStringAsFixed(2),
    '',
    grandAmt.toStringAsFixed(2),
  ]);
  grandTotalRowIndex = tableData.length - 1;

  // 5️⃣ Build Main Report Page
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (context) => [
        pw.Center(
          child: pw.Text(
            'Milk Delivery Report',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            'From: ${startDate.day}-${startDate.month}-${startDate.year}  '
            'To: ${endDate.day}-${endDate.month}-${endDate.year}',
            style: const pw.TextStyle(fontSize: 12),
          ),
        ),
        pw.SizedBox(height: 20),

        // Table
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey700, width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
            4: const pw.FlexColumnWidth(2),
          },
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.indigo),
              children: tableHeaders
                  .map((header) => pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Center(
                          child: pw.Text(
                            header,
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            // Data rows
            ...List.generate(tableData.length, (index) {
              final row = tableData[index];
              final isSubtotal = subtotalRows.contains(index);
              final isGrandTotal = index == grandTotalRowIndex;

              return pw.TableRow(
                decoration: pw.BoxDecoration(
                  color: isGrandTotal
                      ? PdfColors.blue300
                      : isSubtotal
                          ? PdfColors.blue100
                          : PdfColors.white,
                ),
                children: row.map((cellText) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Center(
                      child: pw.Text(
                        cellText,
                        style: pw.TextStyle(
                          fontWeight: (isSubtotal || isGrandTotal)
                              ? pw.FontWeight.bold
                              : pw.FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ],
    ),
  );

  // 6️⃣ Add Summary Page
  final summaryHeaders = ['Customer Name', 'Total Milk (L)', 'Total Amount (Rs)'];
  final summaryRows = customerSummary.entries.map((entry) {
    final name = entry.key;
    final qty = entry.value['qty'] as double;
    final amt = entry.value['amt'] as double;
    return [name, qty.toStringAsFixed(2), amt.toStringAsFixed(2)];
  }).toList();

  // Sort summary by name
  summaryRows.sort((a, b) => a[0].compareTo(b[0]));

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'Customer Summary',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 15),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey700, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.indigo),
                children: summaryHeaders
                    .map((header) => pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Center(
                            child: pw.Text(
                              header,
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              ...summaryRows.map((row) {
                return pw.TableRow(
                  children: row.map((cell) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Center(
                        child: pw.Text(
                          cell,
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Divider(),
          pw.Text(
            'Grand Total: ${grandQty.toStringAsFixed(2)} L  |  Rs${grandAmt.toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
        ],
      ),
    ),
  );

  // 7️⃣ Save and Share
  final dir = await getApplicationDocumentsDirectory();
  final filePath =
      '${dir.path}/MilkDelivery_${startDate.day}_${startDate.month}_${startDate.year}_to_${endDate.day}_${endDate.month}_${endDate.year}.pdf';
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  await Share.shareXFiles([XFile(filePath)],
      text:
          '📄 Milk Delivery Report (${startDate.day}-${startDate.month}-${startDate.year} → ${endDate.day}-${endDate.month}-${endDate.year})');
  Get.snackbar('Success', 'PDF report generated with summary!');
}


// Future<void> exportDeliveriesPDF(
//   DateTime startDate,
//   DateTime endDate,

// ) async {
//   final Box<Edelivered> deliveredBox = Hive.box<Edelivered>('Edelivered');
//   final Box<Customer> customerBox = Hive.box<Customer>('customer');

//   // 1️⃣ Filter deliveries by date range
//   final filteredDeliveries = deliveredBox.values.where((delivery) {
//     final d = delivery.date;
//     return d.isAfter(startDate.subtract(const Duration(days: 1))) &&
//         d.isBefore(endDate.add(const Duration(days: 1)));
//   }).toList();

//   if (filteredDeliveries.isEmpty) {
//     Get.snackbar('No Data', 'No deliveries found in this range.');
//     return;
//   }

//   // 2️⃣ Sort deliveries by customer and date
//   filteredDeliveries.sort((a, b) {
//     int idCompare = a.customerId.compareTo(b.customerId);
//     if (idCompare != 0) return idCompare;
//     return a.date.compareTo(b.date);
//   });

//   // 3️⃣ Create PDF document
//   final pdf = pw.Document();

//   final tableHeaders = [
//     'Customer Name',
//     'Date',
//     'Quantity (L)',
//     'Rate (Rs/L)',
//     'Total (Rs)',
//   ];

//   // 4️⃣ Prepare table data
//   String? currentCustomerId;
//   double subtotalQty = 0;
//   double subtotalAmt = 0;
//   double grandQty = 0;
//   double grandAmt = 0;
//   final List<List<String>> tableData = [];

//   // To track subtotal and grand total styling later
//   final List<int> subtotalRows = [];
//   int grandTotalRowIndex = -1;

//   for (var delivery in filteredDeliveries) {
//     if (currentCustomerId != null && currentCustomerId != delivery.customerId) {
//       // Add subtotal row
//       tableData.add([
//         'Subtotal',
//         '',
//         subtotalQty.toStringAsFixed(2),
//         '',
//         subtotalAmt.toStringAsFixed(2),
//       ]);
//       subtotalRows.add(tableData.length - 1);
//       subtotalQty = 0;
//       subtotalAmt = 0;
//     }

//     currentCustomerId = delivery.customerId;

//     final customer = customerBox.values.firstWhereOrNull(
//         (c) => c.id == delivery.customerId);
//     final name = customer != null
//         ? '${customer.firstName} ${customer.lastName}'
//         : 'Unknown';
//     final rate = customer?.rate ?? 0.0;
//     final total = delivery.quantity * rate;

//     tableData.add([
//       name,
//       '${delivery.date.day}-${delivery.date.month}-${delivery.date.year}',
//       delivery.quantity.toStringAsFixed(2),
//       rate.toStringAsFixed(2),
//       total.toStringAsFixed(2),
//     ]);

//     subtotalQty += delivery.quantity;
//     subtotalAmt += total;
//     grandQty += delivery.quantity;
//     grandAmt += total;
//   }

//   // Last subtotal
//   tableData.add([
//     'Subtotal',
//     '',
//     subtotalQty.toStringAsFixed(2),
//     '',
//     subtotalAmt.toStringAsFixed(2),
//   ]);
//   subtotalRows.add(tableData.length - 1);

//   // Grand total row
//   tableData.add([
//     'GRAND TOTAL',
//     '',
//     grandQty.toStringAsFixed(2),
//     '',
//     grandAmt.toStringAsFixed(2),
//   ]);
//   grandTotalRowIndex = tableData.length - 1;

//   // 5️⃣ Build the PDF page
//   pdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       build: (context) => [
//         pw.Center(
//           child: pw.Text(
//             'Milk Delivery Report',
//             style: pw.TextStyle(
//               fontSize: 20,
//               fontWeight: pw.FontWeight.bold,
//             ),
//           ),
//         ),
//         pw.SizedBox(height: 10),
//         pw.Center(
//           child: pw.Text(
//             'From: ${startDate.day}-${startDate.month}-${startDate.year}   '
//             'To: ${endDate.day}-${endDate.month}-${endDate.year}',
//             style: const pw.TextStyle(fontSize: 12),
//           ),
//         ),
//         pw.SizedBox(height: 20),
//         pw.TableHelper.fromTextArray(
//           headers: tableHeaders,
//           data: tableData,
//           headerDecoration: const pw.BoxDecoration(color: PdfColors.indigo),
//           headerStyle: pw.TextStyle(
//               color: PdfColors.white, fontWeight: pw.FontWeight.bold),
//           headerAlignment: pw.Alignment.center,
//           cellAlignment: pw.Alignment.center,
//           cellStyle: const pw.TextStyle(fontSize: 11),
//           rowDecoration: null,
//         ),
//         pw.SizedBox(height: 20),
//         pw.Divider(),
//         pw.Center(
//           child: pw.Text(
//             'Generated by MilkLog App',
//             style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
//           ),
//         ),
//       ],
//     ),
//   );

//   // 6️⃣ Save file locally
//   final dir = await getApplicationDocumentsDirectory();
//   final filePath =
//       '${dir.path}/MilkDelivery_${startDate.day}_${startDate.month}_${startDate.year}_to_${endDate.day}_${endDate.month}_${endDate.year}.pdf';

//   final file = File(filePath);
//   await file.writeAsBytes(await pdf.save());

//   // 7️⃣ Share or notify success
//   try {
//     await Share.shareXFiles([XFile(filePath)],
//         text:
//             '📄 Milk Delivery Report (${startDate.day}-${startDate.month}-${startDate.year} → ${endDate.day}-${endDate.month}-${endDate.year})');
//     Get.snackbar('Success', 'PDF report generated & shared!');
//   } catch (e) {
//     print('❌ Error sharing file: $e');
//     Get.snackbar('Error', 'Could not share file');
//   }
// }


}
