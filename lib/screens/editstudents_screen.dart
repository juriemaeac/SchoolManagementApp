import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';

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
  late int studentIndex;
  late int studentID;
  late String firstName;
  late String middleName;
  late String lastName;
  late String studentCourse;
  late String studentSubjects;
  late int academicYear;
  late int isInstallment;
  late double accountBalance;

  TextEditingController _studentIDController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _studentCourseController = TextEditingController();
  TextEditingController _studentSubjectsController = TextEditingController();
  TextEditingController _academicYearController = TextEditingController();
  TextEditingController _isInstallmentController = TextEditingController();
  TextEditingController _accountBalanceController = TextEditingController();

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
    studentIndex = widget.index;
    studentID = widget.student.studentID;
    firstName = widget.student.firstName;
    middleName = widget.student.middleName;
    lastName = widget.student.lastName;
    studentCourse = widget.student.studentCourse;
    studentSubjects = widget.student.studentSubjects;
    academicYear = widget.student.academicYear;
    isInstallment = widget.student.isInstallment;
    accountBalance = widget.student.accountBalance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Students'),
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
                  initialValue: studentID.toString(),
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
                  initialValue: firstName,
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
                  initialValue: middleName,
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
                  initialValue: lastName,
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
                  initialValue: studentCourse,
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
                  initialValue: studentSubjects,
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
                  initialValue: academicYear.toString(),
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
                TextFormField(
                  initialValue: isInstallment.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                  ),
                  onChanged: (value) {
                    setState(() {
                      isInstallment = int.parse(value);
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
                  initialValue: accountBalance.toString(),
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
                  child: Text('Save Student'),
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

    studentBox.putAt(
        studentIndex,
        Student(
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
