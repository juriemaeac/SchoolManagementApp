import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.transparent,
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
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Payment? res = box.getAt(index);
                return ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 5, bottom: 5),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Student: ${res!.studentID.toString()}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Cashier: ${res.facultyUsername.toString()}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 102, 101, 101)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Paid ₱${res.transactionAmount.toString()}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 102, 101, 101)),
                                ),
                                Text(
                                  res.transactionDate.toString(),
                                  style: GoogleFonts.quicksand(
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 102, 101, 101)),
                                ),
                              ],
                            ),
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
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
