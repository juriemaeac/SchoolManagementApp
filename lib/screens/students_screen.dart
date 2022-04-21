import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/pdf/api/pdf_api.dart';
import 'package:smapp/pdf/api/pdf_invoice_api.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/pdf/model/studentPDF.dart';
import 'package:smapp/pdf/model/invoice.dart';
import 'package:smapp/pdf/model/supplier.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/screens/editstudents_screen.dart';
import '../models/student_model.dart';
import 'addtransaction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
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
    paymentMethod(int method) {
      print('Method: $method');
      String paymentMethod;
      if (method == 1) {
        paymentMethod = 'Cash';
        print('Payment Method: ${paymentMethod}');
        return paymentMethod;
      } else if (method == 2) {
        paymentMethod = 'Installment';
        print('Payment Method: ${paymentMethod}');
        return paymentMethod;
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
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
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Student? res = box.getAt(index);
                return ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    Text(
                                      res!.studentID.toString(),
                                      style: GoogleFonts.quicksand(
                                        fontSize: 13,
                                        color: const Color.fromARGB(
                                            255, 102, 101, 101),
                                      ),
                                    ),
                                    Text(
                                      " ",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      res.lastName +
                                          ', ' +
                                          res.firstName +
                                          ' ' +
                                          res.middleName,
                                      style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(children: [
                                      Text(
                                        res.studentCourse +
                                            " " +
                                            res.academicYear.toString(),
                                        style: GoogleFonts.quicksand(
                                            fontSize: 13,
                                            color: const Color.fromARGB(
                                                255, 102, 101, 101)),
                                      ),
                                    ])
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                // IconButton(
                                //   icon: const Icon(
                                //     Feather.edit,
                                //     color: Colors.orange,
                                //     size: 20,
                                //   ),
                                IconButton(
                                  padding: new EdgeInsets.all(3.0),
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: Container(
                                    height: 60,
                                    width: 60,
                                    child: SvgPicture.asset(
                                      'assets/edit_svg.svg',
                                    ),
                                  ),
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
                                ),
                                const SizedBox(width: 10),
                                Visibility(
                                  child: IconButton(
                                    padding: new EdgeInsets.all(3.0),
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    icon: Container(
                                      height: 60,
                                      width: 60,
                                      child: SvgPicture.asset(
                                        'assets/billing_svg.svg',
                                      ),
                                    ),
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
                                          builder: (context) =>
                                              AddTransactionScreen(
                                            student: student,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
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
                                    //final balance = res.accountBalance;
                                    final invoice = Invoice(
                                      // faculty: Faculty(
                                      //   username: '',
                                      //   password: '',
                                      //   firstName: '${res.lastName}, ${res.firstName} ${res.middleName}',
                                      //   middleName: '',
                                      //   lastName: '',
                                      //   userFaculty: '',
                                      //   isAdmin: false,
                                      // ),
                                      // supplier: Supplier(
                                      //   name: '${res.lastName}, ${res.firstName} ${res.middleName}',
                                      //   address: 'Sarah Street 9, Beijing, China',
                                      //   paymentInfo: 'https://paypal.me/sarahfieldzz',
                                      // ),
                                      studentPDF: StudentPDF(
                                        studentId: res.studentID,
                                        name:
                                            '${res.lastName}, ${res.firstName} ${res.middleName}',
                                        course:
                                            '${res.studentCourse} ${res.academicYear}',
                                        subjects: res.studentSubjects,
                                      ),
                                      info: InvoiceInfo(
                                        date: date,
                                        balance: res.accountBalance,
                                        description:
                                            'IMPORTANT: Keep this copy. You will be required to present this when you ask for your examination permits and in all you dealings with the school.',
                                        number:
                                            '${paymentMethod(res.isInstallment)}',
                                      ),
                                      items: [
                                        InvoiceItem(
                                          description: 'Coffee',
                                          date: DateTime.now(),
                                          quantity: 3,
                                          vat: 0.19,
                                          unitPrice: 5.99,
                                        ),
                                        InvoiceItem(
                                          description: 'Water',
                                          date: DateTime.now(),
                                          quantity: 8,
                                          vat: 0.19,
                                          unitPrice: 0.99,
                                        ),
                                        InvoiceItem(
                                          description: 'Orange',
                                          date: DateTime.now(),
                                          quantity: 3,
                                          vat: 0.19,
                                          unitPrice: 2.99,
                                        ),
                                        InvoiceItem(
                                          description: 'Apple',
                                          date: DateTime.now(),
                                          quantity: 8,
                                          vat: 0.19,
                                          unitPrice: 3.99,
                                        ),
                                        InvoiceItem(
                                          description: 'Mango',
                                          date: DateTime.now(),
                                          quantity: 1,
                                          vat: 0.19,
                                          unitPrice: 1.59,
                                        ),
                                        InvoiceItem(
                                          description: 'Blue Berries',
                                          date: DateTime.now(),
                                          quantity: 5,
                                          vat: 0.19,
                                          unitPrice: 0.99,
                                        ),
                                        InvoiceItem(
                                          description: 'Lemon',
                                          date: DateTime.now(),
                                          quantity: 4,
                                          vat: 0.19,
                                          unitPrice: 1.29,
                                        ),
                                      ],
                                    );

                                    final pdfFile =
                                        await PdfInvoiceApi.generate(invoice);

                                    PdfApi.openFile(pdfFile);
                                  },
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //onTap: () {}
                );
              },
            );
          }),
    );
  }
}
