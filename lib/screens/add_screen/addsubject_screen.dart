import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/course_model.dart';
import 'package:smapp/models/student_model.dart';

import '../../boxes/boxSubject.dart';
import '../../models/subject_model.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  _AddSubjectScreen createState() => _AddSubjectScreen();
}

class _AddSubjectScreen extends State<AddSubjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Hive.openBox<Subject>(HiveBoxesSubject.subject);
    Hive.openBox<Course>(HiveBoxesCourse.course);
  }

  late String subjectCourse;
  late String subjectYear;
  late String subjectTerm;
  late String subjectCode;
  late int subjectUnit;
  String? courseCheck;
  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
    } else {
      return;
    }
  }

  ifExist(String course, String subject) {
     Box<Subject> subjectBox = Hive.box<Subject>(HiveBoxesSubject.subject);

  }

  @override
  Widget build(BuildContext context) {
    List<String> acadYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
    List<String> acadTerm = ['1st Sem', '2nd Sem', 'Summer'];

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.30,
              width: MediaQuery.of(context).size.width * 0.45,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/subject.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            SafeArea(
              child: Form(
                key: _formKey,
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4.7,
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
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
                                autofocus: true,
                                decoration: const InputDecoration(
                                  labelText: '    Course Code',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  courseCheck = value;
                                  setState(() {
                                    subjectCourse = value;
                                  });
                                },
                                validator: (String? value) {
                                  Box<Course> courseBox =
                                      Hive.box<Course>(HiveBoxesCourse.course);
                                  var count = courseBox.values
                                      .where((course) =>
                                          course.courseCode == value)
                                      .length;
                                  if (value == null ||
                                      value.trim().length == 0) {
                                    return "required";
                                  } else if (count == 0) {
                                    return "Course Code not found";
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
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
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: '     Subject Year',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    subjectYear = value;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      value.trim().length == 0) {
                                    return "required";
                                  } else if (acadYear.contains(value) != true) {
                                    return "! [1st Year, 2nd Year...]";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
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
                                  labelText: '     Subject Term',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    subjectTerm = value;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      value.trim().length == 0) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.7,
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
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
                                  labelText: '     Subject Code',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    subjectCode = value;
                                  });
                                },
                                validator: (String? value) {
                                  Box<Subject> subjectBox = Hive.box<Subject>(
                                      HiveBoxesSubject.subject);
                                  var checker = courseCheck;
                                  //Box<Course> courseBox = Hive.box<Course>(HiveBoxesCourse.course);
                                  if (value == null ||
                                      value.trim().length == 0) {
                                    return "required";
                                  }
                                  for (var subject in subjectBox.values) {
                                    if (subject.subjectCourse == checker) {
                                      if (subject.subjectCode == value) {
                                        return "Subject Code already exists";
                                      }
                                    }
                                    
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
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
                                  labelText: '     Subject Units',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    subjectUnit = int.parse(value);
                                  });
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
                        const SizedBox(
                          height: 8,
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
                                  validated();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const <Widget>[
                                      Text(
                                        'Save Subject',
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Subject> subjectBox = Hive.box<Subject>(HiveBoxesSubject.subject);
    subjectBox.add(Subject(
      subjectCourse: subjectCourse,
      subjectYear: subjectYear,
      subjectTerm: subjectTerm,
      subjectCode: subjectCode,
      subjectUnit: subjectUnit,
    ));
    Navigator.of(context).pop();
  }
}
