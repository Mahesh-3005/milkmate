// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edelivered.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EdeliveredAdapter extends TypeAdapter<Edelivered> {
  @override
  final int typeId = 5;

  @override
  Edelivered read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Edelivered(
      id: fields[0] as String,
      customerId: fields[1] as String,
      date: fields[2] as DateTime,
      quantity: fields[3] as double,
      createdAt: fields[4] as DateTime,
      isDeleted: fields[5] as bool,
      isSynced: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Edelivered obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.isDeleted)
      ..writeByte(6)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EdeliveredAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
