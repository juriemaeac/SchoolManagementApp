// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 4;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      subjectCourse: fields[1] as String,
      subjectYear: fields[2] as String,
      subjectTerm: fields[3] as String,
      subjectCode: fields[4] as String,
      subjectUnit: fields[5] as int,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectCourse)
      ..writeByte(2)
      ..write(obj.subjectYear)
      ..writeByte(3)
      ..write(obj.subjectTerm)
      ..writeByte(4)
      ..write(obj.subjectCode)
      ..writeByte(5)
      ..write(obj.subjectUnit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
