import 'package:hive/hive.dart';
part 'subject_model.g.dart';

@HiveType(typeId: 4)
class Subject extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  late String subjectCourse;
  @HiveField(2)
  late String subjectYear;
  @HiveField(3)
  late String subjectTerm;
  @HiveField(4)
  late Map subjectList;
  //map {subjectCode: subjectUnit}
  Subject(
      {required this.subjectCourse,
      required this.subjectYear,
      required this.subjectTerm,
      required this.subjectList});
}
