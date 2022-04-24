import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/models/payment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/payment_transaction_page.dart';
import 'package:smapp/pdf_payment/api_payment/pdf_api_payment.dart';
import 'package:smapp/pdf_payment/api_payment/pdf_invoice_api_payment.dart';
import 'package:smapp/pdf_payment/model_payment/invoice_payment.dart';
import 'package:smapp/pdf_payment/model_payment/studentPDF_payment.dart';
import '../boxes/boxFaculty.dart';
import '../boxes/boxPayment.dart';
import '../boxes/boxStudent.dart';
import '../models/faculty_model.dart';
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
    Hive.openBox<Student>(HiveBoxesStudent.student);
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

  getStudent(int id) {
    final box = Hive.box<Student>(HiveBoxesStudent.student);
    Student studentInfo;
    for (final student in box.values) {
      if (student.studentID == id) {
        studentInfo = student;
        return studentInfo;
      }
    }
  }

  getCashierInfo(String username) {
    final box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    Faculty facultyInfo;
    if (username != 'admin') {
      for (final faculty in box.values) {
        if (faculty.username == username) {
          facultyInfo = faculty;
          return facultyInfo;
        }
      }
    } else if (username == 'admin') {
      Faculty facultyInfo = Faculty(
        username: 'admin',
        password: 'admin',
        firstName: 'admin',
        middleName: 'admin',
        lastName: 'admin',
        userFaculty: 'admin',
        isAdmin: true,
      );
      return facultyInfo;
    }
    ;
  }

  paymentMethod(int met) {
    String paymentMethod = '';
    if (met == 1) {
      paymentMethod = "Cash";
      return paymentMethod;
    } else if (met == 2) {
      paymentMethod = "Installment";
      return paymentMethod;
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
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4.3,
                              child: Column(
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
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Column(
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
                            ),
                            IconButton(
                              padding: const EdgeInsets.all(3.0),
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              icon: Container(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                  'assets/invoice.png',
                                ),
                              ),
                              onPressed: () async {
                                final date = DateTime.now();
                                Student payor = getStudent(res.studentID) ??
                                    Student(
                                        studentID: 0,
                                        firstName: 'null',
                                        middleName: 'null',
                                        lastName: 'null',
                                        studentCourse: 'null',
                                        studentSubjects: 'null',
                                        academicYear: 0,
                                        isInstallment: 1,
                                        accountBalance: 0);

                                Faculty cashier =
                                    getCashierInfo(res.facultyUsername);
                                final invoice = InvoicePayment(
                                  studentPDFPayment: StudentPDFPayment(
                                    studentId: res.studentID,
                                    name: payor.firstName +
                                        ' ' +
                                        payor.lastName,
                                    course: payor.studentCourse + ' ' + payor.academicYear.toString(),
                                    subjects: 'SUBJECTS',
                                  ),
                                  info: InvoiceInfoPayment(
                                    date: date,
                                    facultyName: cashier.firstName +
                                        ' ' +
                                        cashier.lastName,
                                    description:
                                        'IMPORTANT: Keep this copy. You will be required to present this when you ask for your examination permits and in all you dealings with the school.',
                                    method:
                                        paymentMethod(payor.isInstallment),
                                  ),
                                  payment: Payment(
                                    studentID: res.studentID,
                                    facultyUsername: res.facultyUsername,
                                    transactionDate: res.transactionDate,
                                    transactionAmount: res.transactionAmount,
                                    newAccountBalance: res.newAccountBalance,
                                  ),
                                );

                                final pdfFile =
                                    await PdfInvoiceApiPayment.generate(
                                        invoice);

                                PdfApiPayment.openFile(pdfFile);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(),
                                    ));
                              },
                            ),
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
