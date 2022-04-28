import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/addfaculty_information.dart';
import 'package:smapp/NavigationBar/navbar_faculty_page.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/models/course_model.dart';
import 'package:smapp/models/faculty_model.dart';

import '../../faculty_page.dart';

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

  late int facultyIndex = widget.index;
  late int courseIndex = widget.index;
  String? courseName;
  String? courseCode;
  double? courseFee;

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
    } else {
      return;
    }
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
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width * 0.45,
                              margin: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/course.png',
                                fit: BoxFit.fitWidth,
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
                                      controller: _courseCodeController,
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: '     Course Code',
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
                                        courseCode =
                                            _courseCodeController.value.text;
                                      },
                                      validator: (String? value) {
                                        Box<Course> courseBox =
                                            Hive.box<Course>(
                                                HiveBoxesCourse.course);
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        // for (var course in courseBox.values) {
                                        //   if (course.courseCode == value) {
                                        //     return "Course Code already exists";
                                        //   }
                                        // }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
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
                                      controller: _courseNameController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: '     Course Name',
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
                                        courseName =
                                            _courseNameController.value.text;
                                      },
                                      validator: (String? value) {
                                        Box<Course> courseBox =
                                            Hive.box<Course>(
                                                HiveBoxesCourse.course);
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        // for (var course in courseBox.values) {
                                        //   if (course.courseName == value) {
                                        //     return "Course Name already exists";
                                        //   }
                                        // }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
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
                                      controller: _courseFeeController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: '     Course Fee',
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
                                        courseFee = double.parse(
                                            _courseFeeController.value.text);
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
                                                  'Save Faculty',
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
                                            Navigator.pop(context);
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
                const NavibarFaculty(),
                const AddFacultyInfo(),
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
          courseFee: courseFee ?? 0.0,
        ));
    Navigator.of(context).pop();
  }
}
