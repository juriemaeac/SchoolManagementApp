import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/src/addpayment_information.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/boxes/boxPayment.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';
import 'package:intl/intl.dart';
import '../../Dashboard/src/ProjectStatisticsCards.dart';
import '../../models/payment_model.dart';
import '../../authentication/right_login_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  final Student student;
  final int index;
  const AddTransactionScreen(
      {Key? key, required this.student, required this.index})
      : super(key: key);

  @override
  _AddTransactionScreen createState() => _AddTransactionScreen();
}

class _AddTransactionScreen extends State<AddTransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
    Hive.openBox<Student>(HiveBoxesStudent.student);

    super.initState();
    var user = facultyCredential.getString();
    if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  late int studentIndex = widget.index;
  int? studentID;
  String? firstName;
  String? middleName;
  String? lastName;
  String? studentCourse;
  String? studentSubjects;
  String? academicYear;
  int? isInstallment;
  double? accountBalance;
  String? studentAddress;
  String? academicTerm;

  String? facultyUsername;
  String? transactionDate;
  double? transactionAmount;
  double? newAccountBalance;
  double? oldBalance;

  validated(double oldBalance, double transactionAmount) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit(oldBalance, transactionAmount);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    studentID = widget.student.studentID;
    firstName = widget.student.firstName;
    middleName = widget.student.middleName;
    lastName = widget.student.lastName;
    studentCourse = widget.student.studentCourse;
    studentSubjects = widget.student.studentSubjects;
    academicYear = widget.student.academicYear;
    isInstallment = widget.student.isInstallment;
    accountBalance = widget.student.accountBalance;
    studentAddress = widget.student.studentAddress;

    oldBalance = widget.student.accountBalance;

    TextEditingController _studentIDController = TextEditingController()
      ..text = '${widget.student.studentID}';
    TextEditingController _accountBalanceController = TextEditingController()
      ..text = '${widget.student.accountBalance}';

    @override
    void initState() {
      super.initState();
      _studentIDController.addListener(() {
        setState(() {
          studentID = int.parse(_studentIDController.text);
        });
      });
      _accountBalanceController.addListener(() {
        setState(() {
          accountBalance = double.parse(_accountBalanceController.text);
        });
      });
    }

    @override
    void dispose() {
      _studentIDController.dispose();
      _accountBalanceController.dispose();
      super.dispose();
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

    String? user = facultyCredential.getString();
    String transacDate = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
    String payingStudent = ('$firstName $lastName');

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              margin:
                                  const EdgeInsets.only(bottom: 20, left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                'Add Payment',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 51, 57, 81),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width /
                                        3.25,
                                    child: ProjectStatisticsCardNoGraph(
                                      count:
                                          'Cashier: ${user.substring(0, min(user.length, 15))}..',
                                      name: transacDate,
                                      descriptions: 'Authorized Faculty',
                                      color: const Color(0xffFAAA1E),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width /
                                        3.25,
                                    child: ProjectStatisticsCardNoGraph(
                                      count:
                                          'Payor: ${payingStudent.substring(0, min(payingStudent.length, 15))}..',
                                      name: '$studentID $studentCourse',
                                      descriptions: 'Student Payor',
                                      color: const Color(0xff6C6CE5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              //height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 10, left: 10),
                              margin: const EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: Text(
                                      'Payment Method: ${paymentMethod(isInstallment!)}',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 51, 57, 81),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      enabled: false,
                                      autofocus: true,
                                      controller: _studentIDController,
                                      decoration: const InputDecoration(
                                        labelText: 'Student ID',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          studentID = int.parse(value);
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      enabled: false,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        labelText: 'Account Balance',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      controller: _accountBalanceController,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Payment Amount',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          transactionAmount =
                                              double.parse(value);
                                        });
                                      },
                                      validator: (String? value) {
                                        if (isInstallment == 1) {
                                          if (value == null ||
                                              value.trim().length == 0) {
                                            return "required";
                                          } else if (double.parse(value) <= 0 ||
                                              double.parse(value) >
                                                  oldBalance!) {
                                            return "Payment amount error. Please try again.";
                                          } else if (double.parse(value) <
                                              oldBalance!) {
                                            return "Payment amount error. Student shall pay in full.";
                                          }
                                          return null;
                                        } else if (isInstallment == 2) {
                                          if (value == null ||
                                              value.trim().length == 0) {
                                            return "required";
                                          } else if (double.parse(value) <= 0 ||
                                              double.parse(value) >
                                                  oldBalance!) {
                                            return "Payment amount error. Please try again.";
                                          }
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.orange)))),
                                          onPressed: () {
                                            validated(oldBalance!,
                                                transactionAmount!);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const <Widget>[
                                                Text(
                                                  'Add Payment',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.orange)))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const <Widget>[
                                                Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const NavibarStudent(),
                const AddPaymentInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit(double oldBalance, double transactionAmount) {
    String? user = facultyCredential.getString();

    if (transactionAmount > oldBalance && transactionAmount >= 1.0) {
      return;
    } else {
      double? newAccountBalance = oldBalance - transactionAmount;
      String transacDate = DateFormat("MMMM dd, yyyy").format(DateTime.now());
      Box<Payment> paymentBox = Hive.box<Payment>(HiveBoxesPayment.payment);
      paymentBox.add(Payment(
        studentID: studentID ?? 0,
        transactionAmount: transactionAmount,
        transactionDate: transacDate,
        facultyUsername: user,
        newAccountBalance: newAccountBalance,
      ));
      Box<Student> studentBox = Hive.box<Student>(HiveBoxesStudent.student);
      studentBox.putAt(
          studentIndex,
          Student(
            studentID: studentID ?? 0,
            firstName: firstName ?? '',
            middleName: middleName ?? '',
            lastName: lastName ?? '',
            studentCourse: studentCourse ?? '',
            studentSubjects: studentSubjects ?? '',
            academicYear: academicYear ?? '',
            isInstallment: isInstallment ?? 0,
            accountBalance: newAccountBalance,
            studentAddress: studentAddress ?? '',
            academicTerm: academicTerm ?? '',
          ));
    }
    Navigator.of(context).pop();
  }
}
