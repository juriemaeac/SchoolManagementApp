import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/screens/addstudents_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/screens/editfaculty_screen.dart';
import 'package:smapp/screens/editstudents_screen.dart';
import 'package:smapp/screens/students_screen.dart';
import '../splash_screen.dart';
import 'addfaculty_screen.dart';
import '../models/faculty_model.dart';
import '../models/student_model.dart';
import 'addstudents_screen.dart';

class FacultyScreen extends StatefulWidget {
  final String title;
  const FacultyScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {

  @override
  void initState() {
    super.initState();
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
    var user = facultyCredential.getString();
    if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentScreen(title: 'Student List'),
                      ),
                    );
                  },
                  child: const Text('Student Screen')), 
              ElevatedButton(
                onPressed: () {
                  facultyCredential.setString('');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  );
                },
                child: const Text('Logout')),
            ],
          ),
         
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<Faculty>(HiveBoxesFaculty.faculty).listenable(),
          builder: (context, Box<Faculty> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Faculty list is empty"),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Faculty? res = box.getAt(index);
                return ListTile(
                    //testing lang
                    title: Container(
                      child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(res!.lastName),
                                const Text(", "),
                                Text(res.firstName),
                                const Text(" "),
                                Text(res.middleName),
                              ],
                            ),
                            //
                            ElevatedButton(
                                onPressed: () {
                                  Faculty faculty = Faculty(
                                    username: res.username,
                                    password: res.password,
                                    firstName: res.firstName,
                                    middleName: res.middleName,
                                    lastName: res.lastName,
                                    userFaculty: res.userFaculty,
                                    isAdmin: res.isAdmin,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditFacultyScreen(
                                        faculty: faculty,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Edit')),
                            ElevatedButton(
                                onPressed: () {
                                  res.delete();
                                },
                                child: const Text('Delete')),
                          ]),
                    ),
                    subtitle: Text(res.userFaculty.toString()),
                    onTap: () {});
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFacultyScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
