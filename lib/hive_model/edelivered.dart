import 'package:hive/hive.dart';

part 'edelivered.g.dart'; // generated file

@HiveType(typeId: 5) // unique ID for this model
class Edelivered extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String customerId;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  double quantity;

  @HiveField(4)
  DateTime createdAt;

  // @HiveField(5)
  // DateTime updatedAt;

  @HiveField(5)
  bool isDeleted;

  @HiveField(6)
  bool isSynced; // ✅ new field

  Edelivered({
    required this.id,
    required this.customerId,
    required this.date,
    required this.quantity,
    required this.createdAt,
    // required this.updatedAt,
    required this.isDeleted,
    this.isSynced = false, // default: not synced
  });

    factory Edelivered.fromMap(Map<String, dynamic> map) {
    return Edelivered(
      id: map['id'],
      customerId: map['customerid'],
      date: DateTime.parse(map['date']),
      quantity: map['quantity'] is double
          ? map['quantity']
          : double.tryParse(map['quantity'].toString()) ?? 0.0,
      createdAt: DateTime.parse(map['created_at']),
      // updatedAt: DateTime.parse(map['updated_at']),
      isDeleted: map['is_deleted'],
      isSynced: true,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'customerid':customerId,
      'date':date.toIso8601String(),
      'quantity': quantity,
      'created_at':createdAt.toIso8601String(),
      // 'updated_at':updatedAt.toIso8601String(),
      'is_deleted':isDeleted,
    };
  }
}
