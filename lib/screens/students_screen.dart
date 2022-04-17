import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/screens/addstudents_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/screens/editstudents_screen.dart';
import 'package:smapp/screens/payment_transaction_screen.dart';
import '../splash_screen.dart';
import 'addfaculty_screen.dart';
import '../models/student_model.dart';
import 'addstudents_screen.dart';
import 'addtransaction_screen.dart';
import 'faculty_screen.dart';

class StudentScreen extends StatefulWidget {
  final String title;
  const StudentScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  bool? isAdmin = false;
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    var user = facultyCredential.getString();
    if (user == 'admin') {
      isAdmin = true;
    } else if (user == '') {
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
              Visibility(
                visible: isAdmin ?? false,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FacultyScreen(title: 'Faculty List'),
                        ),
                      );
                    },
                    child: const Text('Faculty Screen')),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(title: 'Payment List'),
                      ),
                    );
                  },
                  child: const Text('Payments')),
              ElevatedButton(
                  onPressed: () {
                    facultyCredential.username = '';
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
                                Row(
                                  children: [
                                    Text(res!.lastName),
                                    const Text(", "),
                                    Text(res.firstName),
                                    const Text(" "),
                                    Text(res.middleName),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                                  mainAxisAlignment: MainAxisAlignment.end,                                
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Student student = Student(
                                          studentID: res.studentID,
                                          firstName: res.firstName,
                                          middleName: res.middleName,
                                          lastName: res.lastName,
                                          studentCourse: res.studentCourse,
                                          studentSubjects: res.studentSubjects,
                                          academicYear: res.academicYear,
                                          isInstallment: res.isInstallment,
                                          accountBalance: res.accountBalance);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditStudentScreen(
                                            student: student,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Edit')
                                ),
                                SizedBox(width: 10),
                                 ElevatedButton(
                                onPressed: () {
                                  Student student = Student(
                                      studentID: res.studentID,
                                      firstName: res.firstName,
                                      middleName: res.middleName,
                                      lastName: res.lastName,
                                      studentCourse: res.studentCourse,
                                      studentSubjects: res.studentSubjects,
                                      academicYear: res.academicYear,
                                      isInstallment: res.isInstallment,
                                      accountBalance: res.accountBalance);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddTransactionScreen(
                                        student: student,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Billing')),
                                SizedBox(width: 10),
                                ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Confirmation',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to delete this student?',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                          textAlign: TextAlign.justify,
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  res.delete();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Delete')
                                ),
                                 SizedBox(width: 10),
                              ],
                            ),
                            
                           
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
