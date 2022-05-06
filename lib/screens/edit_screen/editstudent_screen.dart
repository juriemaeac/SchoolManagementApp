import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/addstudent_information.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/boxes/boxSubject.dart';
import 'package:smapp/models/student_model.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/student_page.dart';

import '../../boxes/boxCourse.dart';
import '../../boxes/boxFaculty.dart';
import '../../models/course_model.dart';
import '../../models/faculty_model.dart';
import '../../models/subject_model.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;
  final int index;
  const EditStudentScreen(
      {Key? key, required this.student, required this.index})
      : super(key: key);

  @override
  _EditStudentScreen createState() => _EditStudentScreen();
}

class _EditStudentScreen extends State<EditStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int studentIndex = widget.index;
  int? studentID;
  String? firstName;
  String? middleName = '';
  String? lastName;
  String? studentCourse;
  String? studentSubjects;
  String? academicYear;
  int? isInstallment;
  double? accountBalance;
  String? studentAddress;
  String? academicTerm;
  int? paymentCounter;
  String? paymentDate;
  bool? isAdmin = false;

  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    var user = facultyCredential.getString();
    if (user == 'admin') {
      isAdmin = true;
    }
  }

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
    } else {
      return;
    }
  }

  checkSubs(String subjects, String course) {
    List<String> subjectsSplit = [];
    List<String> checkedSubs = [];
    var subjectString = subjects;
    var splitSubs = subjectString.split(',');

    for (int i = 0; i < splitSubs.length; i++) {
      if (subjectsSplit.contains(splitSubs[i]) == false) {
        subjectsSplit.add(splitSubs[i]);
      }
    }

    var filteredSubs = subjectsSplit.toSet().toList();

    for (var subs in filteredSubs) {
      Box<Subject> subjectBox = Hive.box<Subject>(HiveBoxesSubject.subject);
      for (var sub in subjectBox.values) {
        if (sub.subjectCode == subs && sub.subjectCourse == course) {
          checkedSubs.add(sub.subjectCode);
        }
      }
    }
    var subsFinal = checkedSubs.join(',');
    return subsFinal.toString();
  }

  subsValidator(String subjects, String course) {
    List<String> subjectsSplit = [];
    List<String> subjectBasis = [];
    var subjectString = subjects;
    var splitSubs = subjectString.split(',');
    var redSubs = 0;
    for (int i = 0; i < splitSubs.length; i++) {
      if (subjectsSplit.contains(splitSubs[i]) == false) {
        subjectsSplit.add(splitSubs[i]);
      }
    }

    var filteredSubs = subjectsSplit.toSet().toList();
    Box<Subject> subjectBox = Hive.box<Subject>(HiveBoxesSubject.subject);

    for (var bSubs in subjectBox.values) {
      if (bSubs.subjectCourse == course) {
        subjectBasis.add(bSubs.subjectCode);
      }
    }

    for (var subs in filteredSubs) {
      if (subjectBasis.contains(subs) == false) {
        redSubs += 1;
      }
    }
    return redSubs;
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
    studentID = widget.student.studentID;
    firstName = widget.student.firstName;
    middleName = widget.student.middleName;
    lastName = widget.student.lastName;
    studentCourse = widget.student.studentCourse;
    studentSubjects = widget.student.studentSubjects;
    academicYear = widget.student.academicYear;
    isInstallment = widget.student.isInstallment;
    accountBalance = widget.student.accountBalance;
    studentAddress = widget.student.studentAddress;
    academicTerm = widget.student.academicTerm;
    paymentCounter = widget.student.paymentCounter;
    paymentDate = widget.student.paymentDate;

    int? oldID = studentID;
    TextEditingController _studentIDController = TextEditingController()
      ..text = '${widget.student.studentID}';
    TextEditingController _firstNameController = TextEditingController()
      ..text = widget.student.firstName;
    TextEditingController _middleNameController = TextEditingController()
      ..text = widget.student.middleName;
    TextEditingController _lastNameController = TextEditingController()
      ..text = widget.student.lastName;
    TextEditingController _studentCourseController = TextEditingController()
      ..text = widget.student.studentCourse;
    TextEditingController _studentSubjectsController = TextEditingController()
      ..text = widget.student.studentSubjects;
    TextEditingController _academicYearController = TextEditingController()
      ..text = widget.student.academicYear;
    TextEditingController _isInstallmentController = TextEditingController()
      ..text = '${widget.student.isInstallment}';
    TextEditingController _accountBalanceController = TextEditingController()
      ..text = '${widget.student.accountBalance}';
    TextEditingController _studentAddressController = TextEditingController()
      ..text = widget.student.studentAddress;
    TextEditingController _academicTermController = TextEditingController()
      ..text = widget.student.academicTerm;

    @override
    void initState() {
      super.initState();
      _studentIDController.addListener(() {
        setState(() {
          studentID = int.parse(_studentIDController.text);
        });
      });
      _firstNameController.addListener(() {
        setState(() {
          firstName = _firstNameController.text;
        });
      });
      _middleNameController.addListener(() {
        setState(() {
          middleName = _middleNameController.text;
        });
      });
      _lastNameController.addListener(() {
        setState(() {
          lastName = _lastNameController.text;
        });
      });
      _studentCourseController.addListener(() {
        setState(() {
          studentCourse = _studentCourseController.text;
        });
      });
      _studentSubjectsController.addListener(() {
        setState(() {
          studentSubjects = _studentSubjectsController.text;
        });
      });
      _academicYearController.addListener(() {
        setState(() {
          academicYear = _academicYearController.text;
        });
      });
      _isInstallmentController.addListener(() {
        setState(() {
          isInstallment = int.parse(_isInstallmentController.text);
        });
      });
      _accountBalanceController.addListener(() {
        setState(() {
          accountBalance = double.parse(_accountBalanceController.text);
        });
      });
      _studentAddressController.addListener(() {
        setState(() {
          studentAddress = _studentAddressController.text;
        });
      });
      _academicTermController.addListener(() {
        setState(() {
          academicTerm = _academicTermController.text;
        });
      });
    }

    @override
    void dispose() {
      _studentIDController.dispose();
      _firstNameController.dispose();
      _middleNameController.dispose();
      _lastNameController.dispose();
      _studentCourseController.dispose();
      _studentSubjectsController.dispose();
      _academicYearController.dispose();
      _isInstallmentController.dispose();
      _accountBalanceController.dispose();
      _studentAddressController.dispose();
      _academicTermController.dispose();
      super.dispose();
    }

    paymentMethod(int met) {
      String paymentMethod = '';
      if (met == 1) {
        paymentMethod = "Cash";
        return paymentMethod;
      } else if (met == 2) {
        paymentMethod = "Installment";
        return paymentMethod;
      }
    }

    String method = paymentMethod(isInstallment!) ?? "";
    List<String> acadYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
    List<String> acadTerm = ['1st Sem', '2nd Sem', 'Summer'];
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Edit Students'),
      // ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              margin:
                                  const EdgeInsets.only(bottom: 20, left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                'Edit Student',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 51, 57, 81),
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                              //height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 10, left: 10),
                              margin: const EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                      enabled: false,
                                      keyboardType: TextInputType.number,
                                      controller: _studentIDController,
                                      decoration: const InputDecoration(
                                        labelText: 'Student ID',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        //setState(() {
                                        studentID = int.parse(
                                            _studentIDController.value.text);
                                        //});
                                      },
                                      validator: (String? value) {
                                        Box<Student> studentBox =
                                            Hive.box<Student>(
                                                HiveBoxesStudent.student);
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required";
                                        }
                                        if (int.parse(value) != oldID) {
                                          for (var student
                                              in studentBox.values) {
                                            if (student.studentID ==
                                                int.parse(value)) {
                                              return "Student ID already exists";
                                            }
                                          }
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                      controller: _firstNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'First Name',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        //setState(() {
                                        firstName =
                                            _firstNameController.value.text;
                                        //});
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                      controller: _middleNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Middle Name',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        //setState(() {
                                        middleName = value;
                                        //});
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          middleName = " ";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                      controller: _lastNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Last Name',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        //setState(() {
                                        lastName = value;
                                        //});
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                      controller: _studentAddressController,
                                      decoration: const InputDecoration(
                                        labelText: 'Home Address',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        //setState(() {
                                        studentAddress = value;
                                        //});
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    0.59) /
                                                2.8,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 9,
                                              //offset: Offset(2, 6),
                                              // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _studentCourseController,
                                          decoration: const InputDecoration(
                                            labelText: 'Student Course',
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            //setState(() {
                                            studentCourse = value;
                                            //});
                                          },
                                          validator: (String? value) {
                                            Box<Course> courseBox =
                                                Hive.box<Course>(
                                                    HiveBoxesCourse.course);
                                            var count = courseBox.values
                                                .where((course) =>
                                                    course.courseCode == value)
                                                .length;
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            } else if (count == 0) {
                                              return "Course not Found";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    0.59) /
                                                3.8,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 9,
                                              //offset: Offset(2, 6),
                                              // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _academicYearController,
                                          decoration: const InputDecoration(
                                            labelText: 'Academic Year',
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            //setState(() {
                                            academicYear = value;
                                            //});
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            } else if (acadYear
                                                    .contains(value) !=
                                                true) {
                                              return "Academic Year Error. [1st Year, 2nd Year...]";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    0.59) /
                                                3.8,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        margin: const EdgeInsets.only(
                                            right: 15, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 9,
                                              //offset: Offset(2, 6),
                                              // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _academicTermController,
                                          decoration: const InputDecoration(
                                            labelText: 'Academic Term',
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            //setState(() {
                                            academicTerm = value;
                                            //});
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            } else if (acadTerm
                                                    .contains(value) !=
                                                true) {
                                              return "Academic Term Error. [1st Sem, 2nd Sem, Summer]";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                      controller: _studentSubjectsController,
                                      decoration: const InputDecoration(
                                        labelText: 'Student Subjects',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        //setState(() {
                                        var subsFinal =
                                            checkSubs(value, studentCourse!);
                                        studentSubjects = subsFinal;
                                        //});
                                      },
                                      validator: (String? value) {
                                        int red = subsValidator(
                                            value!, studentCourse!);
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required";
                                        } else if (red > 0) {
                                          return "$red subjects found conflicted with records.";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        margin: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 9,
                                              //offset: Offset(2, 6),
                                              // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          enabled: false,
                                          //controller:_isInstallmentController,
                                          initialValue: method,
                                          decoration: const InputDecoration(
                                            labelText: 'Payment Method',
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            //setState(() {
                                            isInstallment = int.parse(value);
                                            //});
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        margin: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 9,
                                              //offset: Offset(2, 6),
                                              // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          textAlign: TextAlign.right,
                                          enabled: isRegistrar() ?? false,
                                          controller: _accountBalanceController,
                                          decoration: const InputDecoration(
                                            //hintText: '₱ 0.00',
                                            labelText: 'Account Balance',
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            //setState(() {
                                            accountBalance =
                                                double.parse(value);
                                            //});
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            }
                                            return null;
                                          },
                                        ),
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
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.orange)))),
                                          onPressed: () {
                                            validated();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const <Widget>[
                                                Text(
                                                  'Save Student',
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
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.orange)))),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const StudentPage(),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const NavibarStudent(),
                const AddStudentInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Student> studentBox = Hive.box<Student>(HiveBoxesStudent.student);
    var fSubs = checkSubs(studentSubjects!, studentCourse!);
    studentBox.putAt(
        studentIndex,
        Student(
          studentID: studentID ?? 0,
          firstName: firstName ?? '',
          middleName: middleName ?? '',
          lastName: lastName ?? '',
          studentCourse: studentCourse ?? '',
          studentSubjects: fSubs ?? '',
          academicYear: academicYear ?? '',
          isInstallment: isInstallment ?? 0,
          accountBalance: accountBalance ?? 0.0,
          studentAddress: studentAddress ?? '',
          academicTerm: academicTerm ?? '',
          paymentCounter: paymentCounter ?? 0,
          paymentDate: paymentDate ?? '',
        ));
    Navigator.of(context).pop();
  }
}
