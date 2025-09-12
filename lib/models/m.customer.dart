// class Customer {
//   final String id;
//   final String firstname;
//   final String middlename;
//   final String lastname;
//   final String phone;
//   final String address;
//   final double rate;
//   final double quantity;
//   final String milkType;
//   final String deliveryTime;
//   final String organizationId;
//   final String adminId;
//   final bool isdeleted;
//   final DateTime createdat;
//   final DateTime updatedat;

//   Customer({
//     required this.id,
//     required this.firstname,
//     required this.middlename,
//     required this.lastname,
//     required this.phone,
//     required this.address,
//     required this.rate,
//     required this.quantity,
//     required this.milkType,
//     required this.deliveryTime,
//     required this.organizationId,
//     required this.adminId,
//     required this.isdeleted,
//     required this.createdat,
//     required this.updatedat,
//   });

//   factory Customer.fromMap(Map<String, dynamic> map) {
//     return Customer(
//       id: map['id'],
//       firstname: map['firstname'],
//       middlename: map['middlename']??'',
//       lastname: map['lastname'],
//       phone: map['phone'],
//       address: map['address']??'',
//       rate: map['rate'] is double
//         ? map['rate']
//         : double.tryParse(map['rate'].toString()) ?? 0.0,
//       quantity: map['quantity'] is double
//         ? map['quantity']
//         : double.tryParse(map['quantity'].toString()) ?? 0.0,
//       milkType: map['milk_type']??'',
//       deliveryTime: map['delivery_time']??'',
//       organizationId: map['organization_id'],
//       adminId: map['admin_id'],
//       isdeleted: map['is_deleted'],
//       createdat: DateTime.parse(map['created_at']),
//       updatedat: DateTime.parse(map['updated_at']),
//     );
//   }

//   Map<String,dynamic> toMap(){
//     return {
//       'id':id,
//       'firstname':firstname,
//       'middlename':middlename,
//       'lastname':lastname,
//       'phone':phone,
//       'address':address,
//       'rate':rate,
//       'quantity':quantity,
//       'milk_type':milkType,
//       'delivery_time':deliveryTime,
//       'organization_id':organizationId,
//       'admin_id':adminId,
//       'is_deleted':isdeleted,
//       'created_at':createdat.toIso8601String(),
//       'updated_at':updatedat.toIso8601String(),
//     };
//   }
// }
