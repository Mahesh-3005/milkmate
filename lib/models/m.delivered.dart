// class Delivered {
//   final String id;
//   final String customerId;
//   final DateTime date;
//   final bool delivered;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool isDeleted;

//   Delivered({
//     required this.id,
//     required this.customerId,
//     required this.date,
//     required this.delivered,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDeleted,
//   });

//   factory Delivered.fromMap(Map<String, dynamic> map) {
//     return Delivered(
//       id: map['id'],
//       customerId: map['customerid'],
//       date: map['date'],
//       delivered: map['delivered'],
//       createdAt: DateTime.parse(map['created_at']),
//       updatedAt: DateTime.parse(map['updated_at']),
//       isDeleted: map['is_deleted'],
//     );
//   }

//   Map<String,dynamic> toMap(){
//     return {
//       'id':id,
//       'customerid':customerId,
//       'date':date.toIso8601String(),
//       'delivered':delivered,
//       'created_at':createdAt.toIso8601String(),
//       'updated_at':updatedAt.toIso8601String(),
//       'is_deleted':isDeleted,
//     };
//   }
// }
