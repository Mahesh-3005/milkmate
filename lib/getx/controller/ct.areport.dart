import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:milklog/getx/services/s.areport.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as pdf;
import 'package:printing/printing.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Report period options for milk reports
enum ReportPeriod { daily, weekly, monthly }

class AReportController extends GetxController {
  final service = AReportService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  /// Build a PDF document for a single [customer] and return its bytes.
  Future<Uint8List> buildCustomerPdf(Customer customer) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: pdf.PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(24),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: pw.EdgeInsets.only(top: 8.0),
          child: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}', style: pw.TextStyle(fontSize: 9, color: pdf.PdfColors.grey600)),
        ),
        build: (context) => [
          pw.Container(
            width: double.infinity,
            padding: pw.EdgeInsets.symmetric(vertical: 12),
            decoration: pw.BoxDecoration(color: pdf.PdfColors.blue800, borderRadius: pw.BorderRadius.circular(6)),
            child: pw.Center(
              child: pw.Text('Customer Details', style: pw.TextStyle(fontSize: 20, color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold)),
            ),
          ),
          pw.SizedBox(height: 8),

          pw.Center(
            child: pw.Text(
              DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now().toLocal()),
              style: pw.TextStyle(fontSize: 10, color: pdf.PdfColors.grey700),
            ),
          ),
          pw.SizedBox(height: 12),

          pw.Container(
            padding: pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(color: pdf.PdfColors.white, borderRadius: pw.BorderRadius.circular(8), boxShadow: [pw.BoxShadow(blurRadius: 4, color: pdf.PdfColors.grey300)]),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('${customer.firstName} ${customer.middleName} ${customer.lastName}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                pw.Text('Phone: ${customer.phone}', style: pw.TextStyle(fontSize: 11)),
                pw.Text('Address: ${customer.address}', style: pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 10),

                pw.Table(
                  columnWidths: {0: pw.FlexColumnWidth(2), 1: pw.FlexColumnWidth(4)},
                  children: [
                    _kvRow('Rate', customer.rate.toStringAsFixed(2)),
                    _kvRow('Qty', customer.quantity.toStringAsFixed(2)),
                    _kvRow('Milk Type', customer.milkType),
                    _kvRow('Delivery Time', customer.deliveryTime),
                    _kvRow('Created At', DateFormat('dd/MM/yyyy HH:mm').format(customer.createdAt)),
                    _kvRow('Updated At', DateFormat('dd/MM/yyyy HH:mm').format(customer.updatedAt)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return doc.save();
  }

  // Helper to create a key-value table row for customer details
  pw.TableRow _kvRow(String key, String value) {
    return pw.TableRow(children: [
      pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(key, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
      pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(value)),
    ]);
  }

  /// Build a PDF containing all customers from local storage and return bytes.
  Future<Uint8List> buildAllCustomersPdf() async {
    final customers = service.getCustomerList();

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: pdf.PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: pw.EdgeInsets.only(top: 8.0),
          child: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}', style: pw.TextStyle(fontSize: 9, color: pdf.PdfColors.grey600)),
        ),
        build: (context) => [
          // Top bar
          pw.Container(
            width: double.infinity,
            padding: pw.EdgeInsets.symmetric(vertical: 12),
            decoration: pw.BoxDecoration(color: pdf.PdfColors.blue800, borderRadius: pw.BorderRadius.circular(6)),
            child: pw.Center(child: pw.Text('Customers Details Report', style: pw.TextStyle(fontSize: 20, color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
          ),
          pw.SizedBox(height: 8),
          pw.Center(child: pw.Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now().toLocal()), style: pw.TextStyle(fontSize: 10, color: pdf.PdfColors.grey700))),
          pw.SizedBox(height: 12),

          // Table with zebra stripes
          pw.Table(
            border: pw.TableBorder.symmetric(outside: pw.BorderSide.none, inside: pw.BorderSide(color: pdf.PdfColors.grey300, width: .5)),
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(1.2),
              2: pw.FlexColumnWidth(2.5),
              3: pw.FlexColumnWidth(1),
              4: pw.FlexColumnWidth(1),
              5: pw.FlexColumnWidth(1.2),
              6: pw.FlexColumnWidth(1.2),
            },
            children: [
              // header
              pw.TableRow(
                decoration: pw.BoxDecoration(color: pdf.PdfColors.blue900),
                children: [
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Name', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Phone', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Address', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Rate', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Qty', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Milk Type', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                  pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('Delivery', style: pw.TextStyle(color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold))),
                ],
              ),
              // data rows
              ...customers.asMap().entries.map((entry) {
                final idx = entry.key;
                final c = entry.value;
                final bg = (idx % 2 == 0) ? pdf.PdfColors.white : pdf.PdfColors.grey100;
                return pw.TableRow(
                  decoration: pw.BoxDecoration(color: bg),
                  children: [
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text('${c.firstName} ${c.middleName} ${c.lastName}')),
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(c.phone)),
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(c.address)),
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(c.rate.toString())),
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(c.quantity.toString())),
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(c.milkType)),
                    pw.Padding(padding: pw.EdgeInsets.all(6), child: pw.Text(c.deliveryTime)),
                  ],
                );
              }).toList(),
            ],
          ),

          pw.SizedBox(height: 12),
          pw.Divider(),
          pw.Padding(padding: pw.EdgeInsets.only(top: 6), child: pw.Text('Total customers: ${customers.length}', style: pw.TextStyle(fontSize: 12, color: pdf.PdfColors.grey800))),
        ],
      ),
    );

    return doc.save();
  }

  /// Build and open print/share dialog for all customers.
  Future<void> printAllCustomersPdf() async {
    final bytes = await buildAllCustomersPdf();
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }

  DateTime _startOfWeek(DateTime d) {
    final weekday = d.weekday; // Monday = 1
    return DateTime(d.year, d.month, d.day).subtract(Duration(days: weekday - 1));
  }

  /// Build milk report for given [period]. Aggregates deliveries from `Delivered` and `Edelivered`.
  Future<Uint8List> buildMilkReportPdf(ReportPeriod period, {DateTime? reference}) async {
    final ref = reference ?? DateTime.now();
    DateTime start;
    DateTime end;

    if (period == ReportPeriod.daily) {
      start = DateTime(ref.year, ref.month, ref.day, 0, 0, 0);
      end = DateTime(ref.year, ref.month, ref.day, 23, 59, 59);
    } else if (period == ReportPeriod.weekly) {
      start = _startOfWeek(ref);
      end = start.add(Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    } else {
      start = DateTime(ref.year, ref.month, 1);
      end = DateTime(ref.year, ref.month + 1, 1).subtract(Duration(seconds: 1));
    }

    final deliveredBox = Hive.box<Delivered>('Delivered');
    final edeliveredBox = Hive.box<Edelivered>('Edelivered');
    final customerBox = Hive.box<Customer>('Customer');

    final deliveredInRange = deliveredBox.values.where((d) => !d.isDeleted && d.date.isAfter(start.subtract(Duration(seconds: 1))) && d.date.isBefore(end.add(Duration(seconds: 1)))).toList();
    final edeliveredInRange = edeliveredBox.values.where((e) => !e.isDeleted && e.date.isAfter(start.subtract(Duration(seconds: 1))) && e.date.isBefore(end.add(Duration(seconds: 1)))).toList();

    final Map<String, double> qtyByCustomer = {};
    final Map<String, int> deliveryCount = {};

    for (var d in deliveredInRange) {
      final cust = customerBox.get(d.customerId);
      if (cust == null) continue;
      final q = cust.quantity;
      qtyByCustomer[d.customerId] = (qtyByCustomer[d.customerId] ?? 0) + q;
      deliveryCount[d.customerId] = (deliveryCount[d.customerId] ?? 0) + 1;
    }

    for (var e in edeliveredInRange) {
      qtyByCustomer[e.customerId] = (qtyByCustomer[e.customerId] ?? 0) + e.quantity;
    }

    // Aggregate delivered and edelivered per customer so each customer appears once per table
    // customers list not needed here (we aggregate from boxes directly)

    // delivered: collect per-day quantities (day -> qty) and totals
    final Map<String, Map<int, double>> deliveredDayQtyByCustomer = {};
    for (var d in deliveredInRange) {
      final cust = customerBox.get(d.customerId);
      if (cust == null) continue;
      final day = d.date.day;
      final map = deliveredDayQtyByCustomer.putIfAbsent(cust.id, () => {});
      map[day] = (map[day] ?? 0) + cust.quantity; // each delivered record adds customer's standard qty
    }

    // edelivered: collect per-day extra quantities (day -> qty) and totals
    final Map<String, Map<int, double>> edeliveredDayQtyByCustomer = {};
    for (var e in edeliveredInRange) {
      final cust = customerBox.get(e.customerId);
      if (cust == null) continue;
      final day = e.date.day;
      final map = edeliveredDayQtyByCustomer.putIfAbsent(cust.id, () => {});
      map[day] = (map[day] ?? 0) + e.quantity;
    }

    // Build table rows (one row per customer) for Delivered and Edelivered
    final deliveredRows = <List<String>>[];
    for (var entry in deliveredDayQtyByCustomer.entries) {
      final id = entry.key;
      final dayMap = entry.value;
      final cust = customerBox.get(id);
      if (cust == null) continue;
      final days = dayMap.keys.toList()..sort();
      // Dates column: just day numbers (e.g., "10,11,12")
      final datesOnlyStr = days.map((d) => d.toString()).join(',');
      // Assigned quantity column: show the customer's assigned quantity (single value)
      final assignedQtyStr = cust.quantity.toStringAsFixed(2);
      final daysCount = days.length;
      final qtyTotal = dayMap.values.fold<double>(0, (p, e) => p + e);
      final amount = qtyTotal * cust.rate;
      deliveredRows.add([
        '${cust.firstName} ${cust.middleName} ${cust.lastName}',
        datesOnlyStr,
        assignedQtyStr,
        daysCount.toString(),
        qtyTotal.toStringAsFixed(2),
        cust.rate.toStringAsFixed(2),
        amount.toStringAsFixed(2),
      ]);
    }

    final edeliveredRows = <List<String>>[];
    for (var entry in edeliveredDayQtyByCustomer.entries) {
      final id = entry.key;
      final dayMap = entry.value;
      final cust = customerBox.get(id);
      if (cust == null) continue;
      final days = dayMap.keys.toList()..sort();
      // Dates with per-day qty in the format "10 - 1.00,11 - 2.00"
      final datesWithQtyStr = days.map((d) => '${d} - ${dayMap[d]!.toStringAsFixed(2)}').join(',');
      final qtyTotal = dayMap.values.fold<double>(0, (p, e) => p + e);
      final amount = qtyTotal * cust.rate;
      edeliveredRows.add([
        '${cust.firstName} ${cust.middleName} ${cust.lastName}',
        datesWithQtyStr,
        qtyTotal.toStringAsFixed(2),
        cust.rate.toStringAsFixed(2),
        amount.toStringAsFixed(2),
      ]);
    }

    // Combined summary (one row per customer appearing in either delivered or edelivered)
    final combinedRows = <List<String>>[];
    double totalQty = 0;
    double totalAmount = 0;
    final ids = <String>{}..addAll(deliveredDayQtyByCustomer.keys)..addAll(edeliveredDayQtyByCustomer.keys);
    for (var id in ids) {
      final cust = customerBox.get(id);
      if (cust == null) continue;
      final dqty = deliveredDayQtyByCustomer[id]?.values.fold<double>(0, (p, e) => p + e) ?? 0.0;
      final eqty = edeliveredDayQtyByCustomer[id]?.values.fold<double>(0, (p, e) => p + e) ?? 0.0;
      final total = dqty + eqty;
      final amount = total * cust.rate;
      totalQty += total;
      totalAmount += amount;
      combinedRows.add([
        '${cust.firstName} ${cust.middleName} ${cust.lastName}',
        total.toStringAsFixed(2),
        cust.rate.toStringAsFixed(2),
        amount.toStringAsFixed(2),
      ]);
    }

    final doc = pw.Document();
    final title = period == ReportPeriod.daily ? 'Daily Milk Report' : period == ReportPeriod.weekly ? 'Weekly Milk Report' : 'Monthly Milk Report';
    final rangeText = '${DateFormat('dd/MM/yyyy').format(start)} - ${DateFormat('dd/MM/yyyy').format(end)}';

    doc.addPage(
      pw.MultiPage(
        pageFormat: pdf.PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        footer: (context) => pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}', style: pw.TextStyle(fontSize: 9, color: pdf.PdfColors.grey600))),
        build: (context) => [
          pw.Container(width: double.infinity, padding: pw.EdgeInsets.symmetric(vertical: 12), decoration: pw.BoxDecoration(color: pdf.PdfColors.blue800, borderRadius: pw.BorderRadius.circular(6)), child: pw.Center(child: pw.Text(title, style: pw.TextStyle(fontSize: 18, color: pdf.PdfColors.white, fontWeight: pw.FontWeight.bold)))),
          pw.SizedBox(height: 6),
          pw.Center(child: pw.Text(rangeText, style: pw.TextStyle(fontSize: 10, color: pdf.PdfColors.grey700))),
          pw.SizedBox(height: 12),

          // Table 1: Delivered records — Name, Dates, Qty/Day, Total Days, Total Qty, Rate, Total Amount
          pw.Text('Delivered Records', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            headers: ['Name', 'Dates', 'Quantity', 'Total Days', 'Total Qty', 'Rate', 'Total Amount'],
            data: deliveredRows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: pdf.PdfColors.grey300),
            cellAlignment: pw.Alignment.centerLeft,
            cellHeight: 20,
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(2),
              3: pw.FlexColumnWidth(1),
              4: pw.FlexColumnWidth(1),
              5: pw.FlexColumnWidth(1),
              6: pw.FlexColumnWidth(1),
            },
          ),

          pw.SizedBox(height: 12),

          // Table 2: Extra (Edelivered) records — Name, Dates (day - qty), Total Qty, Rate, Total Amount
          pw.Text('Extra Delivered Records', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            headers: ['Name', 'Dates', 'Total Qty', 'Rate', 'Total Amount'],
            data: edeliveredRows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: pdf.PdfColors.grey300),
            cellAlignment: pw.Alignment.centerLeft,
            cellHeight: 20,
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(3),
              2: pw.FlexColumnWidth(1),
              3: pw.FlexColumnWidth(1),
              4: pw.FlexColumnWidth(1),
            },
          ),

          pw.SizedBox(height: 14),

          // Table 3: Combined summary per customer — Customer, Total Qty, Rate, Total Amount
          pw.Text('Combined Summary', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Table.fromTextArray(
            headers: ['Customer', 'Total Qty', 'Rate', 'Total Amount'],
            data: combinedRows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: pdf.PdfColors.blue900),
            cellAlignment: pw.Alignment.centerLeft,
            cellHeight: 22,
            columnWidths: {0: pw.FlexColumnWidth(2), 1: pw.FlexColumnWidth(1), 2: pw.FlexColumnWidth(1), 3: pw.FlexColumnWidth(1)},
          ),

          pw.SizedBox(height: 12),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [pw.Text('Total Qty: ${totalQty.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)), pw.SizedBox(width: 20), pw.Text('Total Amount: ${totalAmount.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12))]),
        ],
      ),
    );

    return doc.save();
  }

  Future<void> printMilkReport(ReportPeriod period, {DateTime? reference}) async {
    final bytes = await buildMilkReportPdf(period, reference: reference);
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }

  /// Save milk report PDF to local documents directory and return saved path (or null on failure).
  Future<String?> saveMilkReportToFile(ReportPeriod period, {DateTime? reference}) async {
    try {
      final bytes = await buildMilkReportPdf(period, reference: reference);
      final dir = await getApplicationDocumentsDirectory();
      final fileName = '${period.toString().split('.').last}_milk_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      print('Error saving PDF: $e');
      return null;
    }
  }

  /// Build and open the system print/share dialog for the given [customer].
  Future<void> printCustomerPdf(Customer customer) async {
    final bytes = await buildCustomerPdf(customer);
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }
}