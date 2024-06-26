import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';

import '../../boxes/boxCourse.dart';
import '../../boxes/boxSubject.dart';
import '../../models/course_model.dart';
import '../../models/subject_model.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreen createState() => _AddStudentScreen();
}

class _AddStudentScreen extends State<AddStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    Hive.openBox<Subject>(HiveBoxesSubject.subject);
    Hive.openBox<Course>(HiveBoxesCourse.course);
  }

  late int studentID;
  late String firstName;
  late String middleName = '';
  late String lastName;
  late String studentCourse;
  late String studentSubjects;
  late String academicYear;
  late double accountBalance;
  late String studentAddress;
  late int isInstallment = 1;
  late String academicTerm;

  validated(String subjects, double fees) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit(subjects, fees);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _studentSubjects = TextEditingController()
      ..text = courseSubjects.getCourseSubjects();
    TextEditingController _courseFee = TextEditingController()
      ..text = courseSubjects.getCourseFee().toString();
    List<String> acadYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
    List<String> acadTerm = ['1st Sem', '2nd Sem', 'Summer'];
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 9,
                    // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                            //offset: Offset(2, 6),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: '     Student ID',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            studentID = int.parse(value);
                          });
                        },
                        validator: (String? value) {
                          Box<Student> studentBox =
                              Hive.box<Student>(HiveBoxesStudent.student);
                          if (value == null || value.trim().isEmpty) {
                            return "required";
                          }
                          for (var student in studentBox.values) {
                            if (student.studentID == int.parse(value)) {
                              return "Student ID already exists";
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                            //offset: Offset(2, 6),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        autofocus: true,
                        initialValue: '',
                        decoration: const InputDecoration(
                          labelText: '     First Name',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                            //offset: Offset(2, 6),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        autofocus: true,
                        initialValue: '',
                        decoration: const InputDecoration(
                          labelText: '     Middle Name',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            middleName = value;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            middleName = " ";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                            //offset: Offset(2, 6),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        initialValue: '',
                        decoration: const InputDecoration(
                          labelText: '     Last Name',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        initialValue: '',
                        decoration: const InputDecoration(
                          labelText: '     Home Adress',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            studentAddress = value;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          width: (MediaQuery.of(context).size.width * 0.59) / 3,
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 9,
                                //offset: Offset(2, 6),
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: '',
                            decoration: const InputDecoration(
                              labelText: '     Student Course',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              courseSubjects.setCourse(value);
                              setState(() {
                                studentCourse = value;
                              });
                            },
                            validator: (String? value) {
                              Box<Course> courseBox =
                                  Hive.box<Course>(HiveBoxesCourse.course);
                              var count = courseBox.values
                                  .where((course) => course.courseCode == value)
                                  .length;
                              if (value == null || value.trim().isEmpty) {
                                return "required";
                              } else if (count == 0) {
                                return "Course not Found";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width * 0.59) / 4,
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 9,
                                //offset: Offset(2, 6),
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: '     Academic Year',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              courseSubjects.setAcademicYear(value);
                              setState(() {
                                academicYear = value;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required";
                              } else if (acadYear.contains(value) != true) {
                                return "! [1st Year, 2nd Year...]";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width * 0.59) / 4,
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 9,
                                //offset: Offset(2, 6),
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: '     Academic Term',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              courseSubjects.setAcademicTerm(value);
                              setState(() {
                                academicTerm = value;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required";
                              } else if (acadTerm.contains(value) != true) {
                                return "! [1st Sem, 2nd Sem, Summer]";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                            //offset: Offset(2, 6),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _studentSubjects,
                        decoration: const InputDecoration(
                          labelText: '     Student Subjects',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            studentSubjects = value;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              width:
                                  (MediaQuery.of(context).size.width * 0.59) /
                                      2.4,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                              child: const Text(
                                "Payment Methods:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              width:
                                  (MediaQuery.of(context).size.width * 0.59) /
                                      2.4,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    //offset: Offset(2, 6),
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: const Text("Cash"),
                                    leading: Radio<int>(
                                      value: 1,
                                      groupValue: isInstallment,
                                      onChanged: (value) {
                                        setState(() {
                                          isInstallment = value ?? 0;
                                          courseSubjects.setPayment(1);
                                        });
                                      },
                                      activeColor: Colors.orange,
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text("Installment"),
                                    leading: Radio<int>(
                                      value: 2,
                                      groupValue: isInstallment,
                                      onChanged: (value) {
                                        setState(() {
                                          isInstallment = value ?? 0;
                                          courseSubjects.setPayment(2);
                                        });
                                      },
                                      activeColor: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'Account Balance',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 11, bottom: 11),
                              width:
                                  (MediaQuery.of(context).size.width * 0.59) /
                                      2.3,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    //offset: Offset(2, 6),
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller: _courseFee,
                                decoration: const InputDecoration(
                                  hintText: '₱ 0.00',
                                  //labelText: '₱ 0.00',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  accountBalance =
                                      double.parse(_courseFee.text);
                                },
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                            color: Colors.orange)))),
                            onPressed: () {
                              validated(_studentSubjects.text,
                                  double.parse(_courseFee.text));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Text(
                                    'Add Student',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                            color: Colors.orange)))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit(subjects, fees) {
    var subs = subjects;
    var fee = fees;
    String transacDate = DateFormat("MMMM dd, yyyy").format(DateTime.now());
    Box<Student> studentBox = Hive.box<Student>(HiveBoxesStudent.student);
    studentBox.add(Student(
      studentID: studentID,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      studentCourse: studentCourse,
      studentSubjects: subs,
      academicYear: academicYear,
      isInstallment: isInstallment,
      accountBalance: fee,
      studentAddress: studentAddress,
      academicTerm: academicTerm,
      paymentCounter: 0,
      paymentDate: transacDate,
    ));
    Navigator.of(context).pop();
  }
}

class courseSubjects {
  static String subCourse = "";
  static String subAcadYear = "";
  static String subAcadTerm = "";
  static int subPayment = 1;

  static void setCourse(String newValue) {
    subCourse = newValue;
  }

  static void setAcademicYear(String newValue) {
    subAcadYear = newValue;
  }

  static void setAcademicTerm(String newValue) {
    subAcadTerm = newValue;
  }

  static void setPayment(int newValue) {
    subPayment = newValue;
  }

  static String getCourseSubjects() {
    Box<Course> courseBox = Hive.box<Course>(HiveBoxesCourse.course);
    Box<Subject> subjectBox = Hive.box<Subject>(HiveBoxesSubject.subject);
    List<String> courseSubjects = [];
    for (var courses in courseBox.values) {
      if (subCourse == courses.courseCode) {
        for (var sub in subjectBox.values) {
          if (sub.subjectCourse == subCourse) {
            if (sub.subjectYear == subAcadYear &&
                sub.subjectTerm == subAcadTerm) {
              courseSubjects.add(sub.subjectCode);
            }
          }
        }
      }
    }
    String finalSubjects = courseSubjects.join(',');
    return finalSubjects;
  }

  static double getCourseFee() {
    Box<Course> courseBox = Hive.box<Course>(HiveBoxesCourse.course);
    double fee = 0.0;
    for (var courses in courseBox.values) {
      if (subCourse == courses.courseCode) {
        if (subPayment == 1) {
          fee = courses.courseFee;
        } else if (subPayment == 2) {
          fee = courses.courseFee + 1000.0;
        }
      }
    }
    return fee;
  }
}
