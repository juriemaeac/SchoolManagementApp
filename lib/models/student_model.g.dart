// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      studentID: fields[1] as int,
      firstName: fields[2] as String,
      middleName: fields[3] as String,
      lastName: fields[4] as String,
      studentCourse: fields[5] as String,
      studentSubjects: fields[6] as String,
      academicYear: fields[7] as String,
      isInstallment: fields[8] as int,
      accountBalance: fields[9] as double,
      studentAddress: fields[10] as String,
      academicTerm: fields[11] as String,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentID)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.studentCourse)
      ..writeByte(6)
      ..write(obj.studentSubjects)
      ..writeByte(7)
      ..write(obj.academicYear)
      ..writeByte(8)
      ..write(obj.isInstallment)
      ..writeByte(9)
      ..write(obj.accountBalance)
      ..writeByte(10)
      ..write(obj.studentAddress)
      ..writeByte(11)
      ..write(obj.academicTerm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
