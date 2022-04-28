import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';

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
    Hive.openBox<Student>(HiveBoxesStudent.student);
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

  validated(String subjects) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit(subjects);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _studentSubjects = TextEditingController()
      ..text = courseSubjects.getCourseSubjects();
    List<String> courses = ['BSA', 'BSIT', 'BEED', 'BSED'];
    List<String> academicYears = [
      '11',
      '12',
      '21',
      '22',
      '31',
      '32',
      '41',
      '42'
    ];
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
                          if (value == null || value.trim().length == 0) {
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
                          if (value == null || value.trim().length == 0) {
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
                          if (value == null || value.trim().length == 0) {
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
                          if (value == null || value.trim().length == 0) {
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
                          if (value == null || value.trim().length == 0) {
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
                          width: (MediaQuery.of(context).size.width * 0.59) / 2,
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
                              if (value == null || value.trim().length == 0) {
                                return "required";
                              } else if (courses.contains(value) != true) {
                                return "Course not found. [BSA, BSIT, BEED, BSED]";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width:
                              (MediaQuery.of(context).size.width * 0.59) / 2.8,
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
                              //courseSubjects.setAcademicYear(int.parse(value));  ito yung auto populate
                              setState(() {
                                academicYear = value;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.trim().length == 0) {
                                return "required";
                              } else if (acadYear.contains(value) != true) {
                                return "Academic Year Error. [1st Year, 2nd Year...]";
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
                      width: (MediaQuery.of(context).size.width * 0.59) / 2.8,
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
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          //courseSubjects.setAcademicYear(int.parse(value));
                          setState(() {
                            academicTerm = value;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().length == 0) {
                            return "required";
                          } else if (acadTerm.contains(value) != true) {
                            return "Academic Term Error. [1st Sem, 2nd Sem, Summer]";
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
                            studentSubjects = _studentSubjects.text;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().length == 0) {
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
                                initialValue: '',
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
                                  setState(() {
                                    accountBalance = double.parse(value);
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
                              validated(_studentSubjects.text);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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

  void _onFormSubmit(subjects) {
    var subs = subjects;
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
        accountBalance: accountBalance,
        studentAddress: studentAddress,
        academicTerm: academicTerm));
    Navigator.of(context).pop();
  }
}

class courseSubjects {
  static String course = "";
  static int academicYear = 0;

  static void setCourse(String newValue) {
    course = newValue;
  }

  static void setAcademicYear(int newValue) {
    academicYear = newValue;
  }

  static String getCourseSubjects() {
    if (course == "BSIT") {
      if (academicYear == 1) {
        String subjects =
            "GERPH, GESTS, FIL 1, CC 101, CC 102, LIT, PE 101, NSTP 101";
        return subjects;
      } else if (academicYear == 12) {
        String subjects =
            "GEMCW, GEPC, FIL 2, CC 103, HCI 101, MS 101, PE 102, NSTP 2";
        return subjects;
      } else if (academicYear == 21) {
        String subjects =
            "GETCW, GEUS, CC 104, CC 105, IAS 101, IM 101, PE 103";
        return subjects;
      } else if (academicYear == 22) {
        String subjects =
            "GEAA, GEETH, IAS 2, IPT 101, CC 106, MS 102, ADMS, PE 4";
        return subjects;
      } else if (academicYear == 31) {
        String subjects =
            "WS 101, PHYS, NET 101, SA 101, SP 101, APT 102, OS 2";
        return subjects;
      } else if (academicYear == 32) {
        String subjects = "RIZAL, NET 102, SIA 101, DC, PF 101, SIA 102, ITP 3";
        return subjects;
      } else if (academicYear == 41) {
        String subjects = "CAP 101, ITP 4, ITP 5";
        return subjects;
      } else if (academicYear == 42) {
        String subjects = "CAP 102, IT6, FTS 101";
        return subjects;
      } else if (academicYear == 0) {
        String subjects = " -- Select Academic Year -- ";
        return subjects;
      } else {
        return "Subjects not found";
      }
    } else if (course == "BEED") {
      return "Elementary Education Subjects - Not set -";
    } else if (course == "BSED") {
      return "Secondary Education Subjects  - Not set -";
    } else if (course == "BSA") {
      return "Accountancy Subjects  - Not set -";
    } else {
      return "--";
    }
  }
}
