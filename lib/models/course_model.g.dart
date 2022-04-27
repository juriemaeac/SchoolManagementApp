// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 3;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      courseName: fields[1] as String,
      courseFee: fields[2] as double,
      courseCode: fields[3] as String,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.courseName)
      ..writeByte(2)
      ..write(obj.courseFee)
      ..writeByte(3)
      ..write(obj.courseCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
