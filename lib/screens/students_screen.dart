import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/screens/addstudents_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/screens/editstudents_screen.dart';
import 'addfaculty_screen.dart';
import '../models/student_model.dart';
import 'addstudents_screen.dart';
import 'faculty_screen.dart';

class StudentScreen extends StatefulWidget {
  final String title;
  const StudentScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
           ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacultyScreen(title: 'Faculty List'),
                    ),
                  );
                },
                child: const Text('Faculty Screen')),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<Student>(HiveBoxesStudent.student).listenable(),
          builder: (context, Box<Student> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Student list is empty"),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Student? res = box.getAt(index);
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
                                  Student student = Student(
                                      studentID: res.studentID,
                                      firstName: res.firstName,
                                      middleName: res.middleName,
                                      lastName: res.lastName,
                                      studentCourse: res.studentCourse,
                                      studentSubjects:
                                          res.studentSubjects,
                                      academicYear: res.academicYear,
                                      isInstallment: res.isInstallment,
                                      accountBalance: res.accountBalance);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditStudentScreen(
                                        student: student,
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
                    subtitle: Text(res.studentID.toString()),
                    onTap: () {});
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
