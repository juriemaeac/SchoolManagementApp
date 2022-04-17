// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentAdapter extends TypeAdapter<Payment> {
  @override
  final int typeId = 2;

  @override
  Payment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payment(
      studentID: fields[1] as int,
      facultyUsername: fields[2] as String,
      transactionDate: fields[3] as String,
      transactionAmount: fields[4] as double,
      newAccountBalance: fields[5] as double,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentID)
      ..writeByte(2)
      ..write(obj.facultyUsername)
      ..writeByte(3)
      ..write(obj.transactionDate)
      ..writeByte(4)
      ..write(obj.transactionAmount)
      ..writeByte(5)
      ..write(obj.newAccountBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
