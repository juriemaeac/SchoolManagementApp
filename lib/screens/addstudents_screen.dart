import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';

class AddStudentScreen extends StatefulWidget {
  AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreen createState() => _AddStudentScreen();
}

class _AddStudentScreen extends State<AddStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    
    Hive.openBox<Student>(HiveBoxesStudent.student);
  }
  

  late int studentID;
  late String firstName;
  late String middleName;
  late String lastName;
  late String studentCourse;
  late String studentSubjects;
  late int academicYear;
  //int? modeOfPayment;
  late double accountBalance;
  late int isInstallment = 0;

  validated(String subjects) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit(subjects);
      print("Form Validated");
    } else {
      print("Form Not Validated");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _studentSubjects = TextEditingController()
      ..text = courseSubjects.getCourseSubjects();

    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Student ID'),
                  onChanged: (value) {
                    setState(() {
                      studentID = int.parse(value);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'First Name'),
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
                TextFormField(
                  autofocus: true,
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'Middle Name'),
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
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
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
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Student Course',
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
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Academic Year',
                  ),
                  onChanged: (value) {
                    courseSubjects.setAcademicYear(int.parse(value));
                    setState(() {
                      academicYear = int.parse(value);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _studentSubjects,
                  decoration: const InputDecoration(
                    labelText: 'Student Subjects',
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Cash"),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: isInstallment,
                        onChanged: (value) {
                          setState(() {
                            isInstallment = value ?? 0;
                            print(value);
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("Installment"),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: isInstallment,
                        onChanged: (value) {
                          setState(() {
                            isInstallment = value ?? 0;
                            print(value);
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Account Balance',
                  ),
                  onChanged: (value) {
                    setState(() {
                      accountBalance = double.parse(value);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    validated(_studentSubjects.text);
                  },
                  child: Text('Add Student'),
                ),
              ],
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
        accountBalance: accountBalance));   
    Navigator.of(context).pop();
    print(studentBox);
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
      if (academicYear == 11) {
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
        String subjects = 
            "RIZAL, NET 102, SIA 101, DC, PF 101, SIA 102, ITP 3";
        return subjects;
      } else if (academicYear == 41) {
        String subjects = 
            "CAP 101, ITP 4, ITP 5";
        return subjects;
      } else if (academicYear == 42) {
        String subjects = 
            "CAP 102, IT6, FTS 101";
        return subjects;
      } else if (academicYear == 0) {
        String subjects =
            " -- Select Academic Year -- ";
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
