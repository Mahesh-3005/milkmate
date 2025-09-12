import 'package:hive/hive.dart';

part 'organization.g.dart';

@HiveType(typeId: 3) // ⚠️ must be unique across all models
class Organization extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String key;

  @HiveField(3)
  bool isDeleted;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  @HiveField(6)
  bool isSynced; // ✅ New field for sync tracking

  Organization({
    required this.id,
    required this.name,
    required this.key,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false, // default: not synced yet
  });

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map['id'],
      name: map['name'],
      key: map['key'],
      isDeleted: map['is_deleted'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isSynced: true, // ✅ if coming from Supabase, it’s already synced
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'key': key,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
