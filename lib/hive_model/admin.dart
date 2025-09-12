import 'package:hive/hive.dart';

part 'admin.g.dart'; // generated file

@HiveType(typeId: 1) // ⚠️ must be unique across all models
class Admin extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String middleName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String phone;

  @HiveField(5)
  String address;

  @HiveField(6)
  String organizationId;

  @HiveField(7)
  bool isDeleted;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;

  @HiveField(10)
  bool isSynced;

  Admin({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.organizationId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      firstName: map['firstname'],
      middleName: map['middlename'] ?? '',
      lastName: map['lastname'],
      phone: map['phone'],
      address: map['address'] ?? '',
      organizationId: map['organization_id'],
      isDeleted: map['is_deleted'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']), 
      isSynced: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstName,
      'middlename': middleName,
      'lastname': lastName,
      'phone': phone,
      'address': address,
      'organization_id': organizationId,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}