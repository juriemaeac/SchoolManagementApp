import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxPayment.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';
import 'package:intl/intl.dart';
import 'package:smapp/screens/payment_transaction_screen.dart';
import '../models/payment_model.dart';
import '../authentication/right_login_screen.dart';

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
          builder: (context) => LoginScreen(),
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
  int? academicYear;
  int? isInstallment;
  double? accountBalance;

  String? facultyUsername;
  String? transactionDate;
  double? transactionAmount;
  double? newAccountBalance;
  double? oldBalance;

  validated(double oldBalance, double transactionAmount) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit(oldBalance, transactionAmount);
      print("Form Validated");
    } else {
      print("Form Not Validated");
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Payment'),
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
                  enabled: false,
                  autofocus: true,
                  controller: _studentIDController,
                  decoration: InputDecoration(labelText: 'Student ID'),
                  onChanged: (value) {
                    setState(() {
                      studentID = int.parse(value);
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
                  enabled: false,
                  autofocus: false,
                  decoration: InputDecoration(labelText: 'Account Balance'),
                  controller: _accountBalanceController,
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Payment Amount'),
                  onChanged: (value) {
                    setState(() {
                      transactionAmount = double.parse(value);
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
                    validated(oldBalance!, transactionAmount!);
                  },
                  child: Text('Add Payment'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit(double oldBalance, double transactionAmount) {
    String? user = facultyCredential.getString();

    if (transactionAmount > oldBalance) {
      print("Payment Error. Check transaction amount and try again.");
      return;
    } else {
      print("Payment Successful");
      double? newAccountBalance = oldBalance - transactionAmount;
      String transacDate = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
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
              academicYear: academicYear ?? 0,
              isInstallment: isInstallment ?? 0,
              accountBalance: newAccountBalance));
    }
    Navigator.of(context).pop();
    
  }


}
