import 'package:flutter/material.dart';
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
  bool isSearching = false;
  int? searchID;
  bool? isEnabled = true;
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
    isEnabled = true;
    studentIDController.addListener(() {
      setState(() {
        searchID = int.parse(studentIDController.text);
      });
    });

    var user = facultyCredential.getString();
    if (user == 'admin') {
      isAdmin = true;
    } else if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  TextEditingController studentIDController = TextEditingController();

  @override
  void dispose() {
    studentIDController.dispose();
    super.dispose();
  }

  validator(int id) {
    Box<Student> box = Hive.box<Student>(HiveBoxesStudent.student);
    var count = box.values.where((student) => student.studentID == id).length;
    if (count > 0) {
      searchID = id;
      isEnabled = false;
      isSearching = true;
    } else {
      isSearching = false;
      studentIDController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    paymentMethod(int method) {
      String paymentMethod;
      if (method == 1) {
        paymentMethod = 'Cash';
        return paymentMethod;
      } else if (method == 2) {
        paymentMethod = 'Installment';
        return paymentMethod;
      }
    }

    isCashier() {
      final box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
      String username = facultyCredential.getString();
      bool visible = false;
      for (final faculty in box.values) {
        if (username == 'admin') {
          visible = true;
        } else if (faculty.username == username) {
          if (faculty.userFaculty == 'Cashier') {
            visible = true;
          } else {
            visible = false;
          }
        }
      }
      return visible;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.63,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Student List',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 4),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  height: 70,
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
                    autofocus: true,
                    enabled: isEnabled,
                    controller: studentIDController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                      labelText: '    Search by ID',
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
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                  color: Colors.orange)))),
                  onPressed: () {
                    int idVal = int.parse(studentIDController.text);
                    validator(idVal);
                    setState(() {
                      searchID = int.parse(studentIDController.text);
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
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder(
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
                  //itemCount: box.values.length,
                  itemCount: isSearching ? 1 : box.values.length,
                  itemBuilder: (context, index) {
                    final Student? res = isSearching
                        ? box.values
                            .where((student) => student.studentID == searchID)
                            .toList()[index]
                        : box.getAt(index);
                    //Student? res = box.getAt(index);
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
                                    SizedBox(
                                      width: 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                    ),
                                    const SizedBox(width: 30),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    IconButton(
                                      padding: const EdgeInsets.all(3.0),
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      icon: SizedBox(
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
                                    ),
                                    const SizedBox(width: 10),
                                    Visibility(
                                      visible: isCashier(),
                                      child: IconButton(
                                        padding: const EdgeInsets.all(3.0),
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        icon: SizedBox(
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
                                              studentSubjects:
                                                  res.studentSubjects,
                                              academicYear: res.academicYear,
                                              isInstallment: res.isInstallment,
                                              accountBalance:
                                                  res.accountBalance);
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
                                      icon: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/invoice.png',
                                        ),
                                      ),
                                      onPressed: () async {
                                        final date = DateTime.now();
                                        final invoice = Invoice(
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
                                        );

                                        final pdfFile =
                                            await PdfInvoiceApi.generate(
                                                invoice);

                                        PdfApi.openFile(pdfFile);
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
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // return ListView.builder(
                //   itemCount: box.values.where((student) => student.studentID == searchID).length,
                //   itemBuilder: (context, index) {
                //     final Student students = box.values.where((student) => student.studentID == searchID).toList()[index];
                //     return ListTile(
                //     title: Container(
                //       padding: const EdgeInsets.only(
                //           left: 10, right: 10, top: 5, bottom: 5),
                //       margin: const EdgeInsets.only(bottom: 5),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(15.0),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   const SizedBox(width: 20),
                //                   SizedBox(
                //                     width: 100,
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           students.studentID.toString(),
                //                           style: GoogleFonts.quicksand(
                //                             fontSize: 13,
                //                             color: const Color.fromARGB(
                //                                 255, 102, 101, 101),
                //                           ),
                //                         ),
                //                         Text(
                //                           " ",
                //                           style: GoogleFonts.quicksand(
                //                               fontSize: 13,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   const SizedBox(width: 30),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         students.lastName +
                //                             ', ' +
                //                             students.firstName +
                //                             ' ' +
                //                             students.middleName,
                //                         style: GoogleFonts.quicksand(
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.bold),
                //                       ),
                //                       Row(children: [
                //                         Text(
                //                           students.studentCourse +
                //                               " " +
                //                               students.academicYear.toString(),
                //                           style: GoogleFonts.quicksand(
                //                               fontSize: 13,
                //                               color: const Color.fromARGB(
                //                                   255, 102, 101, 101)),
                //                         ),
                //                       ])
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Row(
                //                 children: [
                //                   IconButton(
                //                     padding: const EdgeInsets.all(3.0),
                //                     splashColor: Colors.transparent,
                //                     hoverColor: Colors.transparent,
                //                     icon: SizedBox(
                //                       height: 60,
                //                       width: 60,
                //                       child: SvgPicture.asset(
                //                         'assets/edit_svg.svg',
                //                       ),
                //                     ),
                //                     onPressed: () {
                //                       Student student = Student(
                //                           studentID: students.studentID,
                //                           firstName: students.firstName,
                //                           middleName: students.middleName,
                //                           lastName: students.lastName,
                //                           studentCourse: students.studentCourse,
                //                           studentSubjects: students.studentSubjects,
                //                           academicYear: students.academicYear,
                //                           isInstallment: students.isInstallment,
                //                           accountBalance: students.accountBalance);
                //                       Navigator.push(
                //                         context,
                //                         MaterialPageRoute(
                //                           builder: (context) =>
                //                               EditStudentScreen(
                //                             student: student,
                //                             index: index,
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   ),
                //                   const SizedBox(width: 10),
                //                   Visibility(
                //                     visible: isCashier(),
                //                     child: IconButton(
                //                       padding: const EdgeInsets.all(3.0),
                //                       splashColor: Colors.transparent,
                //                       hoverColor: Colors.transparent,
                //                       icon: SizedBox(
                //                         height: 60,
                //                         width: 60,
                //                         child: SvgPicture.asset(
                //                           'assets/billing_svg.svg',
                //                         ),
                //                       ),
                //                       onPressed: () {
                //                         Student student = Student(
                //                             studentID: students.studentID,
                //                             firstName: students.firstName,
                //                             middleName: students.middleName,
                //                             lastName: students.lastName,
                //                             studentCourse: students.studentCourse,
                //                             studentSubjects:
                //                                 students.studentSubjects,
                //                             academicYear: students.academicYear,
                //                             isInstallment: students.isInstallment,
                //                             accountBalance:
                //                                 students.accountBalance);
                //                         Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                             builder: (context) =>
                //                                 AddTransactionScreen(
                //                               student: student,
                //                               index: index,
                //                             ),
                //                           ),
                //                         );
                //                       },
                //                     ),
                //                   ),
                //                   const SizedBox(width: 10),
                //                   IconButton(
                //                     padding: const EdgeInsets.all(3.0),
                //                     splashColor: Colors.transparent,
                //                     hoverColor: Colors.transparent,
                //                     icon: SizedBox(
                //                       height: 60,
                //                       width: 60,
                //                       child: Image.asset(
                //                         'assets/invoice.png',
                //                       ),
                //                     ),
                //                     onPressed: () async {
                //                       final date = DateTime.now();
                //                       final invoice = Invoice(
                //                         studentPDF: StudentPDF(
                //                           studentId: students.studentID,
                //                           name:
                //                               '${students.lastName}, ${students.firstName} ${students.middleName}',
                //                           course:
                //                               '${students.studentCourse} ${students.academicYear}',
                //                           subjects: students.studentSubjects,
                //                         ),
                //                         info: InvoiceInfo(
                //                           date: date,
                //                           balance: students.accountBalance,
                //                           description:
                //                               'IMPORTANT: Keep this copy. You will be required to present this when you ask for your examination permits and in all you dealings with the school.',
                //                           number:
                //                               '${paymentMethod(students.isInstallment)}',
                //                         ),
                //                       );

                //                       final pdfFile =
                //                           await PdfInvoiceApi.generate(
                //                               invoice);

                //                       PdfApi.openFile(pdfFile);
                //                     },
                //                   ),
                //                   // IconButton(
                //                   //   padding: const EdgeInsets.all(3.0),
                //                   //   splashColor: Colors.transparent,
                //                   //   hoverColor: Colors.transparent,
                //                   //   icon: SizedBox(
                //                   //     height: 60,
                //                   //     width: 60,
                //                   //     child: SvgPicture.asset(
                //                   //       'assets/delete_svg.svg',
                //                   //     ),
                //                   //   ),
                //                   //   onPressed: () {
                //                   //     res.delete();
                //                   //   },
                //                   // ),
                //                   const SizedBox(width: 20),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
                //   },
                // );
              }),
        ],
      ),
    );
  }
}
