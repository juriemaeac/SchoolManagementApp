import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/src/calendar_section.dart';
import 'package:smapp/CalendarSpace/src/profile_section.dart';
import 'package:smapp/CalendarSpace/src/student_buttons.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/models/faculty_model.dart';
import '../boxes/boxStudent.dart';
import '../models/student_model.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({Key? key}) : super(key: key);

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  bool? isAdmin = false;
  bool? isUserRegistrar = false;
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    var user = facultyCredential.getString();
    if (user == 'admin') {
      isAdmin = true;
    }
    isUserRegistrar = isRegistrar();
  }

  isRegistrar() {
    final box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    String username = facultyCredential.getString();
    bool visible = false;
    if (username == 'admin') {
      visible = true;
      return visible;
    }
    for (final faculty in box.values) {
      if (faculty.username == username) {
        if (faculty.userFaculty == 'Registrar') {
          visible = true;
          return visible;
        } else {
          visible = false;
          return visible;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF7F7FF),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 9,
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const TopContainer(), //profile
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.28,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/girl_read.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            const CalendarSection(), //Month Year
            Visibility(
                visible: isUserRegistrar ?? false,
                child: const StudentButtons()),
          ],
        ),
      ),
    );
  }
}
