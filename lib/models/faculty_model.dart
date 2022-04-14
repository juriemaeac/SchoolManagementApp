import 'package:hive/hive.dart';
part 'faculty_model.g.dart';

@HiveType(typeId: 1)
class Faculty {
  @HiveField(0)
  late String? id;
  @HiveField(1)
  late String username = '';
  @HiveField(2)
  late String password = '';
  @HiveField(3)
  late String firstName = '';
  @HiveField(4)
  late String middleName = '';
  @HiveField(5)
  late String lastName = '';
  @HiveField(6)
  late String userFaculty = '';
  @HiveField(7)
  late bool isAdmin = false;

  Faculty(
      {required this.username,
      required this.password,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.userFaculty,
      required this.isAdmin});
}
