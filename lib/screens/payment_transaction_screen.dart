import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/models/course_model.dart';
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
  int? counter = 0;

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

  getCourseFee(String course, int method) {
    final box = Hive.box<Course>(HiveBoxesCourse.course);
    for (final crs in box.values) {
      if (crs.courseCode == course) {
        if (method == 1) {
          double fee = crs.courseFee;
          return fee;
        } else if (method == 2) {
          double fee = crs.courseFee + 1000.0;
          return fee;
        }
      }
    }
  }

  payBreakdown(
      double balance, double payment, int count, String lastDate, int method) {
    if (method == 1) {
      var payments = '- Nothing Follows -';
      return payments;
    } else if (method == 2) {
      List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];

      var splitDate = lastDate.split(' ');
      String initMonth = splitDate[0];
      int initMonthIndex = months.indexOf(initMonth);
      int initIndex = initMonthIndex;

      List<String> iterableMonths = [];

      if (initMonthIndex == 8) {
        //September
        iterableMonths = ['October', 'November', 'December', 'January'];
      } else if (initMonthIndex == 9) {
        //October
        iterableMonths = ['November', 'December', 'January', 'February'];
      } else if (initMonthIndex == 10) {
        //November
        iterableMonths = ['December', 'January', 'February', 'March'];
      } else if (initMonthIndex == 11) {
        //December
        iterableMonths = ['January', 'February', 'March', 'April'];
      } else {
        iterableMonths = months;
      }

      List<String> paymentBreakdown = [];

      initIndex++;
      if (count == 1) {
        int divisor = 4;
        //counter = count + 1;
        balance = balance / divisor;
        for (int i = 0; i < 4; i++) {
          paymentBreakdown.add(
              "${iterableMonths[initIndex]} : Php ${balance.toStringAsFixed(2)}");
          initIndex++;
        }
      } else if (count == 2) {
        int divisor = 3;
        //counter = count + 1;
        balance = balance / divisor;
        for (int i = 0; i < 3; i++) {
          paymentBreakdown.add(
              "${iterableMonths[initIndex]} : Php ${balance.toStringAsFixed(2)}");
          initIndex++;
        }
      } else if (count == 3) {
        int divisor = 2;
        //counter = count + 1;
        balance = balance / divisor;
        for (int i = 0; i < 2; i++) {
          paymentBreakdown.add(
              "${iterableMonths[initIndex]} : Php ${balance.toStringAsFixed(2)}");
          initIndex++;
        }
      } else if (count == 4) {
        //counter = count + 1;
        for (int i = 0; i < 1; i++) {
          paymentBreakdown.add(
              "${iterableMonths[initIndex]} : Php ${balance.toStringAsFixed(2)}");
          initIndex++;
        }
      }

      var payments = paymentBreakdown.join('\n');
      return payments.toString();
    }
  }

  TextEditingController searchIDController = TextEditingController();

  @override
  void dispose() {
    searchIDController.dispose();
    super.dispose();
  }

  // validator(int id) {
  //   Box<Payment> box = Hive.box<Payment>(HiveBoxesPayment.payment);
  //   var count = box.values.where((payment) => payment.studentID == id).length;

  //   if (count > 0) {
  //     searchID = id;
  //     isEnabled = false;
  //     isSearching = true;
  //     searchCount = count;
  //   } else {
  //     isSearching = false;
  //     searchIDController.clear();
  //   }
  // }

  validatorSurname(String surName) {
    final studentBox = Hive.box<Student>(HiveBoxesStudent.student);
    int studID = 0;
    Box<Payment> box = Hive.box<Payment>(HiveBoxesPayment.payment);

    for (final student in studentBox.values) {
      if (student.lastName == surName) {
        studID = student.studentID;
      }
    }

    var count =
        box.values.where((payment) => payment.studentID == studID).length;

    if (count > 0) {
      searchID = studID;
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
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
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
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 11),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: '    Search by Surname',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(3),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                              color: Colors.orange)))),
                              onPressed: () {
                                // int idVal = int.parse(searchIDController.text);
                                // validator(idVal);
                                String surName = searchIDController.text;
                                validatorSurname(surName);
                                setState(() {
                                  //searchID = int.parse(searchIDController.text);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(7),
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
                            const SizedBox(width: 10),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff6C6CE5),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: const Icon(Icons.refresh_rounded,
                                            color: Colors.white, size: 15)),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PaymentPage(),
                                      ),
                                    );
                                  }),
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
                        int reverseIndex = box.length - 1 - index;
                        final Payment? res = isSearching
                            ? box.values
                                .where(
                                    (payment) => payment.studentID == searchID)
                                .toList()[index]
                            : box.getAt(reverseIndex);
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
                                      width: MediaQuery.of(context).size.width /
                                          4.3,
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
                                      width:
                                          MediaQuery.of(context).size.width / 4,
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
                                        Student payor =
                                            getStudent(res.studentID) ??
                                                Student(
                                                    studentID: 0,
                                                    firstName: 'null',
                                                    middleName: 'null',
                                                    lastName: 'null',
                                                    studentCourse: 'null',
                                                    studentSubjects: 'null',
                                                    studentAddress: 'null',
                                                    academicTerm: 'null',
                                                    academicYear: 'null',
                                                    isInstallment: 1,
                                                    accountBalance: 0,
                                                    paymentCounter: 0,
                                                    paymentDate: 'null');

                                        Faculty cashier =
                                            getCashierInfo(res.facultyUsername);
                                        print(
                                            "Balance: ${payor.accountBalance}");
                                        String breakdown = payBreakdown(
                                            payor.accountBalance,
                                            res.transactionAmount,
                                            payor.paymentCounter,
                                            res.transactionDate,
                                            payor.isInstallment);
                                        print('\n');
                                        print(breakdown);
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
                                            courseFee: getCourseFee(
                                                payor.studentCourse,
                                                payor.isInstallment),
                                            paymentMode: payor.isInstallment,
                                            paymentBalance:
                                                payor.accountBalance,
                                            paymentBreakdown: breakdown,
                                          ),
                                          info: InvoiceInfoPayment(
                                            date: date,
                                            facultyName: cashier.firstName +
                                                ' ' +
                                                cashier.lastName,
                                            description:
                                                'IMPORTANT: Please note of the following schedules of payments. Kindly settle your account on or before the scheduled date. Online Permit will be sent to the teachers. Promissory Note will be issued with the same fee of 15.00. PN form will be available online thru NPCST Finance Department FB page. Students with paid down payment and settled accounts will be allowed to take the exam. Disregard this notice if payment has been made. Thank you.',
                                            method: paymentMethod(
                                                payor.isInstallment),
                                          ),
                                          payment: Payment(
                                            studentID: res.studentID,
                                            facultyUsername:
                                                res.facultyUsername,
                                            transactionDate:
                                                res.transactionDate,
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
