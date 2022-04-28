import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/addstudent_information.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/student_page.dart';

import '../../boxes/boxCourse.dart';
import '../../boxes/boxFaculty.dart';
import '../../models/course_model.dart';
import '../../models/faculty_model.dart';

class EditCourseScreen extends StatefulWidget {
  final Course course;
  final int index;
  const EditCourseScreen({Key? key, required this.course, required this.index})
      : super(key: key);

  @override
  _EditCourseScreen createState() => _EditCourseScreen();
}

class _EditCourseScreen extends State<EditCourseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int courseIndex = widget.index;
  String? courseName;
  String? courseCode;
  double? courseFee;

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

  bool? isAdmin = false;

  isRegistrar() {
    final box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    String username = facultyCredential.getString();
    bool visible = false;
    for (final faculty in box.values) {
      if (username == 'admin') {
        visible = true;
      } else if (faculty.username == username) {
        if (faculty.userFaculty == 'Registrar') {
          visible = true;
        } else {
          visible = false;
        }
      }
    }
    return visible;
  }

  @override
  Widget build(BuildContext context) {
    courseName = widget.course.courseName;
    courseCode = widget.course.courseCode;
    courseFee = widget.course.courseFee;

    TextEditingController _courseNameController = TextEditingController()
      ..text = widget.course.courseName;
    TextEditingController _courseCodeController = TextEditingController()
      ..text = widget.course.courseCode;
    TextEditingController _courseFeeController = TextEditingController()
      ..text = widget.course.courseFee.toString();

    @override
    void initState() {
      super.initState();
      _courseNameController.addListener(() {
        setState(() {
          courseName = _courseNameController.text;
        });
      });
      _courseCodeController.addListener(() {
        setState(() {
          courseCode = _courseCodeController.text;
        });
      });
      _courseFeeController.addListener(() {
        setState(() {
          courseFee = double.tryParse(_courseFeeController.text);
        });
      });
    }

    @override
    void dispose() {
      _courseNameController.dispose();
      _courseCodeController.dispose();
      _courseFeeController.dispose();
      super.dispose();
    }

    return Scaffold(
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
                                'Edit Course',
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
                                            value.trim().length == 0) {
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
                                            value.trim().length == 0) {
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
                                            value.trim().length == 0) {
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
                                            value.trim().length == 0) {
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
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        } else if (courses.contains(value) !=
                                            true) {
                                          return "Course not found. [BSA, BSIT, BEED, BSED]";
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
                                        studentSubjects = value;
                                        //});
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
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
                                      controller: _academicYearController,
                                      keyboardType: TextInputType.number,
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
                                            value.trim().length == 0) {
                                          return "required";
                                        } else if (acadYear.contains(value) !=
                                            true) {
                                          return "Academic Year Error. [1st Year, 2nd Year...]";
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
                                      controller: _academicTermController,
                                      keyboardType: TextInputType.number,
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
                                            value.trim().length == 0) {
                                          return "required";
                                        } else if (acadTerm.contains(value) !=
                                            true) {
                                          return "Academic Term Error. [1st Sem, 2nd Sem, Summer]";
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
                                                value.trim().length == 0) {
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
                                          enabled: isRegistrar(),
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
                                                value.trim().length == 0) {
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
                                      const SizedBox(width: 20),
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
                const Navibar(),
                const AddStudentInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Course> courseBox = Hive.box<Course>(HiveBoxesCourse.course);
    courseBox.putAt(
        courseIndex,
        Course(
            courseCode: courseCode ?? '',
            courseName: courseName ?? '',
            courseFee: courseFee ?? 0.0,));
    Navigator.of(context).pop();
  }
}
