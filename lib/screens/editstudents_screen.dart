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

  late int studentIndex = widget.index;
  late int studentID;
  late String firstName;
  late String middleName;
  late String lastName;
  late String studentCourse;
  late String studentSubjects;
  late int academicYear;
  late int isInstallment;
  late double accountBalance;

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
    TextEditingController _studentIDController = TextEditingController()
      ..text = '${widget.student.studentID}';
    TextEditingController _firstNameController = TextEditingController()
      ..text = '${widget.student.firstName}';
    TextEditingController _middleNameController = TextEditingController()
      ..text = '${widget.student.middleName}';
    TextEditingController _lastNameController = TextEditingController()
      ..text = '${widget.student.lastName}';
    TextEditingController _studentCourseController = TextEditingController()
      ..text = '${widget.student.studentCourse}';
    TextEditingController _studentSubjectsController = TextEditingController()
      ..text = '${widget.student.studentSubjects}';
    TextEditingController _academicYearController = TextEditingController()
      ..text = '${widget.student.academicYear}';
    TextEditingController _isInstallmentController = TextEditingController()
      ..text = '${widget.student.isInstallment}';
    TextEditingController _accountBalanceController = TextEditingController()
      ..text = '${widget.student.accountBalance}';

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
                  controller: _studentIDController,
                  decoration: InputDecoration(labelText: 'Student ID'),
                  onChanged: (value) {
                    //setState(() {
                      studentID = int.parse(value);
                    //});
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
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  onChanged: (value) {
                    //setState(() {
                      firstName = value;
                    //});
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
                  controller: _middleNameController,
                  decoration: InputDecoration(labelText: 'Middle Name'),
                  onChanged: (value) {
                    //setState(() {
                      middleName = value;
                    //});
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  onChanged: (value) {
                    //setState(() {
                      lastName = value;
                    //});
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _studentCourseController,
                  decoration: const InputDecoration(
                    labelText: 'Student Course',
                  ),
                  onChanged: (value) {
                    //setState(() {
                      studentCourse = value;
                    //});
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _studentSubjectsController,
                  decoration: const InputDecoration(
                    labelText: 'Student Subjects',
                  ),
                  onChanged: (value) {
                    //setState(() {
                      studentSubjects = value;
                    //});
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _academicYearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Academic Year',
                  ),
                  onChanged: (value) {
                    //setState(() {
                      academicYear = int.parse(value);
                    //});
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _isInstallmentController,
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                  ),
                  onChanged: (value) {
                    //setState(() {
                      isInstallment = int.parse(value);
                    //});
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _accountBalanceController,
                  decoration: const InputDecoration(
                    labelText: 'Account Balance',
                  ),
                  onChanged: (value) {
                    //setState(() {
                      accountBalance = double.parse(value);
                    //});
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
    print(
      "Student Index: $studentIndex",
    );
    print(
      "Student Info Update: $studentID, $firstName",
    );
    print(studentBox);
  }
}
