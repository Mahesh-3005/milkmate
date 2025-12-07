import 'package:hive/hive.dart';

part 'income.g.dart';

@HiveType(typeId: 7)
class IncomeModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String category;

  @HiveField(5)
  String adminId;

  @HiveField(6)
  bool isDeleted;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  bool isSynced;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.adminId,
    required this.isDeleted,
    required this.createdAt,
    this.isSynced = false,
  });

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'] is double
          ? map['amount']
          : double.tryParse(map['amount'].toString()) ?? 0.0,
      date: DateTime.parse(map['date']),
      category: map['category'],
      adminId: map['admin_id'],
      isDeleted: map['is_deleted'],
      createdAt: DateTime.parse(map['created_at']),
      isSynced: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'admin_id': adminId,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
