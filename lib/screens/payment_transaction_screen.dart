import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/payment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/screens/students_screen.dart';
import '../boxes/boxPayment.dart';
import '../splash_screen.dart';
import '../models/student_model.dart';

class PaymentScreen extends StatefulWidget {
  final String title;
  const PaymentScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
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
                        builder: (context) =>
                            const StudentScreen(title: 'Student List'),
                      ),
                    );
                  },
                  child: const Text('Student Screen')),
              ElevatedButton(
                  onPressed: () {
                    facultyCredential.username = '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
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
              Hive.box<Payment>(HiveBoxesPayment.payment).listenable(),
          builder: (context, Box<Payment> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Payment list is empty"),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Payment? res = box.getAt(index);
                return ListTile(
                    //testing lang
                    title: Container(
                      child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: [
                                Text("Student: ${res!.studentID.toString()}"),
                                const Text(" : "),
                                Text(
                                    "Paid ${res.transactionAmount.toString()}"),
                              ],
                            ),
                            //Print to PDF
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      // Student student = Student(
                                      //     studentID: res.studentID,
                                      //     firstName: res.firstName,
                                      //     middleName: res.middleName,
                                      //     lastName: res.lastName,
                                      //     studentCourse: res.studentCourse,
                                      //     studentSubjects: res.studentSubjects,
                                      //     academicYear: res.academicYear,
                                      //     isInstallment: res.isInstallment,
                                      //     accountBalance: res.accountBalance);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => EditStudentScreen(
                                      //       student: student,
                                      //       index: index,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: const Text('View Record')),
                              ],
                            ),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return AlertDialog(
                            //             title: const Text(
                            //               'Confirmation',
                            //               style: TextStyle(
                            //                   fontSize: 20,
                            //                   fontWeight: FontWeight.bold,
                            //                   color: Colors.red),
                            //             ),
                            //             content: const Text(
                            //               'Are you sure you want to delete this student?',
                            //               style: TextStyle(
                            //                   fontSize: 15,
                            //                   color: Colors.black),
                            //               textAlign: TextAlign.justify,
                            //             ),
                            //             actions: <Widget>[
                            //               Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                 children: [
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       res.delete();
                            //                       Navigator.pop(context);
                            //                     },
                            //                     child: const Text('Delete'),
                            //                   ),
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                     },
                            //                     child: const Text('Cancel'),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ],
                            //           );
                            //         },
                            //       );
                            //     },
                            //     child: const Text('Delete')),
                          ]),
                    ),
                    subtitle: Row(
                      children: [
                        Text("Cashier: ${res.facultyUsername.toString()}"),
                        const Text(" @ "),
                        Text(res.transactionDate.toString()),
                      ],
                    ),
                    onTap: () {});
              },
            );
          }),
    );
  }
}
