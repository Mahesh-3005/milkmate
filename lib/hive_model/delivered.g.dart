// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivered.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveredAdapter extends TypeAdapter<Delivered> {
  @override
  final int typeId = 4;

  @override
  Delivered read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Delivered(
      id: fields[0] as String,
      customerId: fields[1] as String,
      date: fields[2] as DateTime,
      createdAt: fields[3] as DateTime,
      isDeleted: fields[4] as bool,
      isSynced: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Delivered obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.isDeleted)
      ..writeByte(5)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveredAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
