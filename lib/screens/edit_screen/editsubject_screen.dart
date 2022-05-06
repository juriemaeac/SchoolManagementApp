import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/addcoursesubject_information.dart';
import 'package:smapp/NavigationBar/navbar_maintenance_page.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/boxes/boxSubject.dart';
import 'package:smapp/models/course_model.dart';
import 'package:smapp/models/subject_model.dart';

class EditSubjectScreen extends StatefulWidget {
  final Subject subject;
  final int index;
  const EditSubjectScreen(
      {Key? key, required this.subject, required this.index})
      : super(key: key);

  @override
  _EditSubjectScreen createState() => _EditSubjectScreen();
}

class _EditSubjectScreen extends State<EditSubjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int subjectIndex = widget.index;
  String? subjectCourse;
  String? subjectYear;
  String? subjectTerm;
  String? subjectCode;
  int? subjectUnit;

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    subjectCourse = widget.subject.subjectCourse;
    subjectYear = widget.subject.subjectYear;
    subjectTerm = widget.subject.subjectTerm;
    subjectCode = widget.subject.subjectCode;
    subjectUnit = widget.subject.subjectUnit;

    final String currentSubjectCode = widget.subject.subjectCode;
    final String currentSubjectCourse = widget.subject.subjectCourse;

    TextEditingController _subjectCourseController = TextEditingController()
      ..text = widget.subject.subjectCourse;
    TextEditingController _subjectYearController = TextEditingController()
      ..text = widget.subject.subjectYear;
    TextEditingController _subjectTermController = TextEditingController()
      ..text = widget.subject.subjectTerm;
    TextEditingController _subjectCodeController = TextEditingController()
      ..text = widget.subject.subjectCode;
    TextEditingController _subjectUnitController = TextEditingController()
      ..text = widget.subject.subjectUnit.toString();

    @override
    void initState() {
      super.initState();
      _subjectCourseController.addListener(() {
        setState(() {
          subjectCourse = _subjectCourseController.text;
        });
      });
      _subjectYearController.addListener(() {
        setState(() {
          subjectYear = _subjectYearController.text;
        });
      });
      _subjectTermController.addListener(() {
        setState(() {
          subjectTerm = _subjectTermController.text;
        });
      });
      _subjectCodeController.addListener(() {
        setState(() {
          subjectCode = _subjectCodeController.text;
        });
      });
      _subjectUnitController.addListener(() {
        setState(() {
          subjectUnit = int.parse(_subjectUnitController.text);
        });
      });
    }

    @override
    void dispose() {
      _subjectCourseController.dispose();
      _subjectYearController.dispose();
      _subjectTermController.dispose();
      _subjectCodeController.dispose();
      _subjectUnitController.dispose();
      super.dispose();
    }

    List<String> acadYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
    List<String> acadTerm = ['1st Sem', '2nd Sem', 'Summer'];

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
                                'Edit Subject',
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.8,
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
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: _subjectCourseController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: '    Course Code',
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
                                            subjectCourse =
                                                _subjectCourseController.text;
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
                                              return "Course Code not found";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
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
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: _subjectYearController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: '     Subject Year',
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
                                            subjectYear =
                                                _subjectYearController.text;
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            } else if (acadYear
                                                    .contains(value) !=
                                                true) {
                                              return "! [1st Year, 2nd Year...]";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
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
                                          autofocus: true,
                                          controller: _subjectTermController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: '     Subject Term',
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
                                            subjectTerm =
                                                _subjectTermController.text;
                                          },
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            } else if (acadTerm
                                                    .contains(value) !=
                                                true) {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.3,
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
                                          autofocus: true,
                                          controller: _subjectCodeController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: '     Subject Code',
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
                                            subjectCode =
                                                _subjectCodeController.text;
                                          },
                                          validator: (String? value) {
                                            Box<Subject> subjectBox =
                                                Hive.box<Subject>(
                                                    HiveBoxesSubject.subject);
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "required";
                                            } else if (currentSubjectCode !=
                                                value) {
                                              for (var subject
                                                  in subjectBox.values) {
                                                if (subject.subjectCode ==
                                                        value &&
                                                    subject.subjectCourse ==
                                                        currentSubjectCourse) {
                                                  return "Subject Code already Exists.";
                                                }
                                              }
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.1,
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
                                          autofocus: true,
                                          controller: _subjectUnitController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: '     Subject Units',
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
                                            subjectUnit = int.parse(
                                                _subjectUnitController
                                                    .value.text);
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
                const NavibarMaintenance(),
                const AddCourseSubjectInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Subject> subjectBox = Hive.box<Subject>(HiveBoxesSubject.subject);
    subjectBox.putAt(
        subjectIndex,
        Subject(
          subjectCourse: subjectCourse ?? '',
          subjectYear: subjectYear ?? '',
          subjectTerm: subjectTerm ?? '',
          subjectUnit: subjectUnit ?? 0,
          subjectCode: subjectCode ?? '',
        ));
    Navigator.of(context).pop();
  }
}
