import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';
import 'package:smapp/screens/students_screen.dart';

import '../screens/faculty_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? adminUsername = "admin";
  String? adminPassword = "password";
  late String username;
  late String password;

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (username == adminUsername && password == adminPassword) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FacultyScreen(title: 'Faculty List'),
            ));
      } else {
        // check if credential is in hive faculty
        // add username and password in global list
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentScreen(title: 'Student List'),
            ));
      }
      print("Form Validated");
    } else {
      print("Form Not Validated");
      return;
    }
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'Enter Username'),
                  onChanged: (value) {
                    setState(() {
                      username = value;
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
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      labelText: 'Enter Passowrd',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                  autofocus: true,
                  initialValue: '',
                  onChanged: (value) {
                    setState(() {
                      password = value;
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
                  child: Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
