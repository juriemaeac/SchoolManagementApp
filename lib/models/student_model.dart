import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  late int studentID = 0;
  @HiveField(2)
  late String firstName = '';
  @HiveField(3)
  late String middleName = '';
  @HiveField(4)
  late String lastName = '';
  @HiveField(5)
  late String studentCourse = '';
  @HiveField(6)
  late String studentSubjects = '';
  @HiveField(7)
  late int academicYear = 0;
  @HiveField(8)
  late int isInstallment = 0;
  @HiveField(9)
  late double accountBalance = 0.0;

  Student(
      {required this.studentID,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.studentCourse,
      required this.studentSubjects,
      required this.academicYear,
      required this.isInstallment,
      required this.accountBalance});
}
