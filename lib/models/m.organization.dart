// class Organization {
//   final String id;
//   final String name;
//   final String key;
//   final bool isdeleted;
//   final DateTime createdat;
//   final DateTime updatedat;

//   Organization({
//     required this.id,
//     required this.name,
//     required this.key,
//     required this.isdeleted,
//     required this.createdat,
//     required this.updatedat,
//   });

//   factory Organization.fromMap(Map<String, dynamic> map) {
//     return Organization(
//       id: map['id'],
//       name: map['name'],
//       key : map['key'],
//       isdeleted: map['is_deleted'],
//       createdat: DateTime.parse(map['created_at']),
//       updatedat: DateTime.parse(map['updated_at']),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'key': key,
//       'is_deleted': isdeleted,
//       'created_at': createdat.toIso8601String(),
//       'updated_at': updatedat.toIso8601String(),
//     };
//   }
// }
