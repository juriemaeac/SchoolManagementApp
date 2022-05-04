import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  late int studentID;
  @HiveField(2)
  late String firstName;
  @HiveField(3)
  late String middleName;
  @HiveField(4)
  late String lastName;
  @HiveField(5)
  late String studentCourse;
  @HiveField(6)
  late String studentSubjects;
  @HiveField(7)
  late String academicYear;
  @HiveField(8)
  late int isInstallment;
  @HiveField(9)
  late double accountBalance;
  @HiveField(10)
  late String studentAddress;
  @HiveField(11)
  late String academicTerm;
  @HiveField(12)
  late int paymentCounter;
  @HiveField(13)
  late String paymentDate;
  Student(
      {required this.studentID,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.studentCourse,
      required this.studentSubjects,
      required this.academicYear,
      required this.isInstallment,
      required this.accountBalance,
      required this.studentAddress,
      required this.academicTerm,
      required this.paymentCounter,
      required this.paymentDate});
}
