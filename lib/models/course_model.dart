import 'package:hive/hive.dart';
part 'course_model.g.dart';

@HiveType(typeId: 3)
class Course extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  late String courseName;
  @HiveField(2)
  late double courseFee;
  @HiveField(3)
  late String courseCode;
  Course({required this.courseName, required this.courseFee, required this.courseCode});
}