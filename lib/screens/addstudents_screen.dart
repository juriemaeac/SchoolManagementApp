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

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print("Form Validated");
    } else {
      print("Form Not Validated");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Student Subjects',
                  ),
                  onChanged: (value) {
                    setState(() {
                      studentSubjects = value;
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
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Academic Year',
                  ),
                  onChanged: (value) {
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
                      isInstallment = value??0;
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
                      isInstallment = value??0;
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
                    validated();
                  },
                  child: Text('Add Student'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Student> studentBox = Hive.box<Student>(HiveBoxesStudent.student);
    studentBox.add(Student(
        studentID: studentID,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        studentCourse: studentCourse,
        studentSubjects: studentSubjects,
        academicYear: academicYear,
        isInstallment: isInstallment,
        accountBalance: accountBalance));
    Navigator.of(context).pop();
    print(studentBox);
  }
}
