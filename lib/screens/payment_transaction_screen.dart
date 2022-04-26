import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isSearching = false;
  int? searchID;
  bool? isEnabled = true;
  int? searchCount = 1;
  @override
  void initState() {
    super.initState();
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
    Hive.openBox<Student>(HiveBoxesStudent.student);
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
    var user = facultyCredential.getString();
    isEnabled = true;
    if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
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

  TextEditingController searchIDController = TextEditingController();

  @override
  void dispose() {
    searchIDController.dispose();
    super.dispose();
  }

  validator(int id) {
    Box<Payment> box = Hive.box<Payment>(HiveBoxesPayment.payment);
    var count = box.values.where((payment) => payment.studentID == id).length;
    if (count > 0) {
      searchID = id;
      isEnabled = false;
      isSearching = true;
      searchCount = count;
    } else {
      isSearching = false;
      searchIDController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.width * 0.56,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment List',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 25, right: 25),
                              height: 30,
                              width: 220,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    //offset: Offset(2, 6),
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                enabled: isEnabled,
                                controller: searchIDController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 11),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  labelText: '    Search by ID',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          side: const BorderSide(color: Colors.orange)))),
                              onPressed: () {
                                int idVal = int.parse(searchIDController.text);
                                validator(idVal);
                                setState(() {
                                  searchID = int.parse(searchIDController.text);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.search_rounded,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box<Payment>(HiveBoxesPayment.payment).listenable(),
              builder: (context, Box<Payment> box, _) {
                if (box.values.isEmpty) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 120),
                      child: const Text("Payment list is empty")),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: isSearching ? searchCount : box.values.length,
                      itemBuilder: (context, index) {
                        //int reverseIndex = box.length - 1 - index;
                        final Payment? res = isSearching
                            ? box.values
                                .where((payment) => payment.studentID == searchID)
                                .toList()[index]
                            : box.getAt(index);
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
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4.3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                      icon: SizedBox(
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
                                            course: payor.studentCourse +
                                                ' ' +
                                                payor.academicYear.toString(),
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
                                            transactionAmount:
                                                res.transactionAmount,
                                            newAccountBalance:
                                                res.newAccountBalance,
                                          ),
                                        );
                            
                                        final pdfFile =
                                            await PdfInvoiceApiPayment.generate(
                                                invoice);
                            
                                        PdfApiPayment.openFile(pdfFile);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PaymentPage(),
                                            ));
                                      },
                                    ),
                                    // IconButton(
                                    //   padding: const EdgeInsets.all(3.0),
                                    //   splashColor: Colors.transparent,
                                    //   hoverColor: Colors.transparent,
                                    //   icon: SizedBox(
                                    //     height: 60,
                                    //     width: 60,
                                    //     child: SvgPicture.asset(
                                    //       'assets/delete_svg.svg',
                                    //     ),
                                    //   ),
                                    //   onPressed: () {
                                    //     res.delete();
                                    //   },
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
