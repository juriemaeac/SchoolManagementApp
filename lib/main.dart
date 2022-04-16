import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/login_screen.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/models/student_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/splash_screen.dart';



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(FacultyAdapter());
  await Hive.openBox<Student>(HiveBoxesStudent.student);
  await Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      // home: StudentScreen(
      //   title: 'Student List',
      // ),
      home: const SplashScreen(),
    );
  }
}
