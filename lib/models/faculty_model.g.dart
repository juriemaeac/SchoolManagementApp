// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacultyAdapter extends TypeAdapter<Faculty> {
  @override
  final int typeId = 1;

  @override
  Faculty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Faculty(
      username: fields[1] as String,
      password: fields[2] as String,
      firstName: fields[3] as String,
      middleName: fields[4] as String,
      lastName: fields[5] as String,
      userFaculty: fields[6] as String,
      isAdmin: fields[7] as bool,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Faculty obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.middleName)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.userFaculty)
      ..writeByte(7)
      ..write(obj.isAdmin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
