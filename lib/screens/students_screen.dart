import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/screens/addstudents_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/screens/editstudents_screen.dart';
import 'package:smapp/screens/payment_transaction_screen.dart';
import '../splash_screen.dart';
import 'addfaculty_screen.dart';
import '../models/student_model.dart';
import 'addstudents_screen.dart';
import 'addtransaction_screen.dart';
import 'faculty_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentScreen extends StatefulWidget {
  final String title;
  const StudentScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  bool? isAdmin = false;

  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    var user = facultyCredential.getString();
    if (user == 'admin') {
      isAdmin = true;
    } else if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<Student>(HiveBoxesStudent.student).listenable(),
          builder: (context, Box<Student> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Student list is empty"),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Student? res = box.getAt(index);
                return ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    Text(
                                      res!.studentID.toString(),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 13,
                                        color: const Color.fromARGB(
                                            255, 102, 101, 101),
                                      ),
                                    ),
                                    Text(
                                      " ",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      res.lastName +
                                          ', ' +
                                          res.firstName +
                                          ' ' +
                                          res.middleName,
                                      style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(children: [
                                      Text(
                                        res.studentCourse +
                                            " " +
                                            res.academicYear.toString(),
                                        style: GoogleFonts.quicksand(
                                            fontSize: 13,
                                            color: const Color.fromARGB(
                                                255, 102, 101, 101)),
                                      ),
                                    ])
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                // IconButton(
                                //   icon: const Icon(
                                //     Feather.edit,
                                //     color: Colors.orange,
                                //     size: 20,
                                //   ),
                                IconButton(
                                  padding: new EdgeInsets.all(3.0),
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: Container(
                                    height: 60,
                                    width: 60,
                                    child: SvgPicture.asset(
                                      'assets/edit_svg.svg',
                                    ),
                                  ),
                                  onPressed: () {
                                    Student student = Student(
                                        studentID: res.studentID,
                                        firstName: res.firstName,
                                        middleName: res.middleName,
                                        lastName: res.lastName,
                                        studentCourse: res.studentCourse,
                                        studentSubjects: res.studentSubjects,
                                        academicYear: res.academicYear,
                                        isInstallment: res.isInstallment,
                                        accountBalance: res.accountBalance);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditStudentScreen(
                                          student: student,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  padding: new EdgeInsets.all(3.0),
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: Container(
                                    height: 60,
                                    width: 60,
                                    child: SvgPicture.asset(
                                      'assets/billing_svg.svg',
                                    ),
                                  ),
                                  onPressed: () {
                                    Student student = Student(
                                        studentID: res.studentID,
                                        firstName: res.firstName,
                                        middleName: res.middleName,
                                        lastName: res.lastName,
                                        studentCourse: res.studentCourse,
                                        studentSubjects: res.studentSubjects,
                                        academicYear: res.academicYear,
                                        isInstallment: res.isInstallment,
                                        accountBalance: res.accountBalance);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddTransactionScreen(
                                          student: student,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  padding: new EdgeInsets.all(3.0),
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: Container(
                                    height: 60,
                                    width: 60,
                                    child: SvgPicture.asset(
                                      'assets/delete_svg.svg',
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Confirmation',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this student?',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            textAlign: TextAlign.justify,
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    res.delete();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Delete'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //onTap: () {}
                );
              },
            );
          }),
    );
  }
}
