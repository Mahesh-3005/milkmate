import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 2) // ⚠️ make sure this is unique across models
class Customer extends HiveObject {
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
  double rate;

  @HiveField(7)
  double quantity;

  @HiveField(8)
  String milkType;

  @HiveField(9)
  String deliveryTime;

  @HiveField(10)
  String organizationId;

  @HiveField(11)
  String adminId;

  @HiveField(12)
  bool isDeleted;

  @HiveField(13)
  DateTime createdAt;

  @HiveField(14)
  DateTime updatedAt;

  @HiveField(15)
  bool isSynced; // ✅ new field for sync tracking

  Customer({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.rate,
    required this.quantity,
    required this.milkType,
    required this.deliveryTime,
    required this.organizationId,
    required this.adminId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false, // default not synced
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      firstName: map['firstname'],
      middleName: map['middlename'] ?? '',
      lastName: map['lastname'],
      phone: map['phone'],
      address: map['address'] ?? '',
      rate: map['rate'] is double
          ? map['rate']
          : double.tryParse(map['rate'].toString()) ?? 0.0,
      quantity: map['quantity'] is double
          ? map['quantity']
          : double.tryParse(map['quantity'].toString()) ?? 0.0,
      milkType: map['milk_type'] ?? '',
      deliveryTime: map['delivery_time'] ?? '',
      organizationId: map['organization_id'],
      adminId: map['admin_id'],
      isDeleted: map['is_deleted'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isSynced: true, // ✅ records coming from Supabase are already synced
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
      'rate': rate,
      'quantity': quantity,
      'milk_type': milkType,
      'delivery_time': deliveryTime,
      'organization_id': organizationId,
      'admin_id': adminId,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
