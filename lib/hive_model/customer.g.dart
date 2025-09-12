// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 2;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as String,
      firstName: fields[1] as String,
      middleName: fields[2] as String,
      lastName: fields[3] as String,
      phone: fields[4] as String,
      address: fields[5] as String,
      rate: fields[6] as double,
      quantity: fields[7] as double,
      milkType: fields[8] as String,
      deliveryTime: fields[9] as String,
      organizationId: fields[10] as String,
      adminId: fields[11] as String,
      isDeleted: fields[12] as bool,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      isSynced: fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.middleName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.rate)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.milkType)
      ..writeByte(9)
      ..write(obj.deliveryTime)
      ..writeByte(10)
      ..write(obj.organizationId)
      ..writeByte(11)
      ..write(obj.adminId)
      ..writeByte(12)
      ..write(obj.isDeleted)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
