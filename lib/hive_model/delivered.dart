import 'package:hive/hive.dart';

part 'delivered.g.dart'; // generated file

@HiveType(typeId: 4) // unique ID for this model
class Delivered extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String customerId;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  DateTime createdAt;

  // @HiveField(4)
  // DateTime updatedAt;

  @HiveField(4)
  bool isDeleted;

  @HiveField(5)
  bool isSynced; // ✅ new field

  Delivered({
    required this.id,
    required this.customerId,
    required this.date,
    required this.createdAt,
    // required this.updatedAt,
    required this.isDeleted,
    this.isSynced = false, // default: not synced
  });

    factory Delivered.fromMap(Map<String, dynamic> map) {
    return Delivered(
      id: map['id'],
      customerId: map['customerid'],
      date: DateTime.parse(map['date']),
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
      'created_at':createdAt.toIso8601String(),
      // 'updated_at':updatedAt.toIso8601String(),
      'is_deleted':isDeleted,
    };
  }
}
