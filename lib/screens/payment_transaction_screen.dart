import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/models/payment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/pdf_payment/api_payment/pdf_api_payment.dart';
import 'package:smapp/pdf_payment/api_payment/pdf_invoice_api_payment.dart';
import 'package:smapp/pdf_payment/model_payment/invoice_payment.dart';
import 'package:smapp/pdf_payment/model_payment/studentPDF_payment.dart';
import '../boxes/boxPayment.dart';

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
                                    final invoice = InvoicePayment(
                                      studentPDFPayment: StudentPDFPayment(
                                        studentId: res.studentID,
                                        name:
                                            'NAMEE',
                                        course:
                                            'COURSEE',
                                        subjects: 'SUBJECTS',
                                      ),
                                      info: InvoiceInfoPayment(
                                        date: date,
                                        facultyName: 'FACULTY NAME',
                                        description:
                                            'IMPORTANT: Keep this copy. You will be required to present this when you ask for your examination permits and in all you dealings with the school.',
                                        method:
                                            'PAYMENT METHOD',
                                      ),
                                      payment: Payment(
                                        studentID: res.studentID,
                                        facultyUsername:
                                            res.facultyUsername,
                                        transactionDate:
                                            res.transactionDate,
                                        transactionAmount: res.transactionAmount,
                                        newAccountBalance: res.newAccountBalance,
                                      ),
                                      
                                    );

                                    final pdfFile =
                                        await PdfInvoiceApiPayment.generate(invoice);

                                    PdfApiPayment.openFile(pdfFile);
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
