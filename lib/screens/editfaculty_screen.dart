import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/models/student_model.dart';

class EditFacultyScreen extends StatefulWidget {
  final Faculty faculty;
  final int index;
  const EditFacultyScreen(
      {Key? key, required this.faculty, required this.index})
      : super(key: key);

  @override
  _EditFacultyScreen createState() => _EditFacultyScreen();
}

class _EditFacultyScreen extends State<EditFacultyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int facultyIndex = widget.index;
  String? username;
  String? password;
  String? firstName;
  String? middleName;
  String? lastName;
  String? userFaculty;
  bool? isAdmin;

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

    username = widget.faculty.username;
    password = widget.faculty.password;
    firstName = widget.faculty.firstName;
    middleName = widget.faculty.middleName;
    lastName = widget.faculty.lastName;
    userFaculty = widget.faculty.userFaculty;
    isAdmin = widget.faculty.isAdmin;
    
    TextEditingController _usernameController = TextEditingController()
      ..text = widget.faculty.username;
    TextEditingController _passwordController = TextEditingController()
      ..text = widget.faculty.password;
    TextEditingController _firstNameController = TextEditingController()
      ..text = widget.faculty.firstName;
    TextEditingController _middleNameController = TextEditingController()
      ..text = widget.faculty.middleName;
    TextEditingController _lastNameController = TextEditingController()
      ..text = widget.faculty.lastName;
    TextEditingController _userFacultyController = TextEditingController()
      ..text = widget.faculty.userFaculty;
    
    @override
    void initState() {
      super.initState();
      _usernameController.addListener(() {
        setState(() {
          username = _usernameController.text;
        });
      });
      _passwordController.addListener(() {
        setState(() {
          password = _passwordController.text;
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
      _userFacultyController.addListener(() {
        setState(() {
          userFaculty = _userFacultyController.text;
        });
      });   
    }

    @override
    void dispose() {
      _usernameController.dispose();
      _passwordController.dispose();
      _firstNameController.dispose();
      _middleNameController.dispose();
      _lastNameController.dispose();
      _userFacultyController.dispose();    
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Faculty'),
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
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Faculty Username'),
                  onChanged: (value) {
                    //setState(() {
                    firstName = _usernameController.value.text;
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
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Faculty Password'),
                  onChanged: (value) {
                    //setState(() {
                    firstName = _passwordController.value.text;
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
                    firstName = _firstNameController.value.text;
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
                  controller: _userFacultyController,
                  decoration: const InputDecoration(
                    labelText: 'Faculty Department',
                  ),
                  onChanged: (value) {
                    //setState(() {
                    userFaculty = value;
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
                  child: Text('Save Faculty'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Faculty> facultyBox = Hive.box<Faculty>(HiveBoxesFaculty.faculty);

    facultyBox.putAt(
        facultyIndex,
        Faculty(
          username: username ?? '',
          password: password ?? '',
          firstName: firstName ?? '',
          middleName: middleName ?? '',
          lastName: lastName ?? '',
          userFaculty: userFaculty ?? '',
          isAdmin: isAdmin ?? false,));
    Navigator.of(context).pop();
    print(
      "Faculty Index: $facultyIndex",
    );
    print(
      "Student Info Update: $userFaculty, $firstName",
    );
    print(facultyBox);
  }
}
