// class Admin {
//   final String id;
//   final String firstname;
//   final String middlename;
//   final String lastname;
//   final String phone;
//   final String address;
//   final String organizationId;
//   final bool isdeleted;
//   final DateTime createdat;
//   final DateTime updatedat;

//   Admin({
//     required this.id,
//     required this.firstname,
//     required this.middlename,
//     required this.lastname,
//     required this.phone,
//     required this.address,
//     required this.organizationId,
//     required this.isdeleted,
//     required this.createdat,
//     required this.updatedat,
//   });

//   factory Admin.fromMap(Map<String, dynamic> map) {
//     return Admin(
//       id: map['id'],
//       firstname: map['firstname'],
//       middlename: map['middlename']??'',
//       lastname: map['lastname'],
//       phone: map['phone'],
//       address: map['address']??'',
//       organizationId: map['organization_id'],
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
//       'organization_id':organizationId,
//       'is_deleted':isdeleted,
//       'created_at':createdat.toIso8601String(),
//       'updated_at':updatedat.toIso8601String(),
//     };
//   }
// }
