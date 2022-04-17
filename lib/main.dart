import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/models/student_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/splash_screen.dart';

import 'boxes/boxPayment.dart';
import 'models/payment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(FacultyAdapter());
  Hive.registerAdapter(PaymentAdapter());
  await Hive.openBox<Student>(HiveBoxesStudent.student);
  await Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
   await Hive.openBox<Payment>(HiveBoxesPayment.payment);
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
