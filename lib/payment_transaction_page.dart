import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/payment_information.dart';
import 'package:smapp/CalendarSpace/student_information_section.dart';
import 'package:smapp/Dashboard/src/ProjectStatisticsCards.dart';
import 'package:smapp/NavigationBar/navbar_payment_page.dart';
import 'package:smapp/NavigationBar/navbar_payment_states.dart';
import 'package:smapp/Student/student_tabs.dart';
import 'package:smapp/screens/payment_transaction_screen.dart';
import 'package:smapp/screens/students_screen.dart';
import 'package:intl/intl.dart';
import 'boxes/boxPayment.dart';
import 'models/payment_model.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
  }

  countPayments() {
    final box = Hive.box<Payment>(HiveBoxesPayment.payment);
    String transacDate = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
    int paymentsNow = 0;
    for (final payment in box.values) {
      if (payment.transactionDate == transacDate) {
        paymentsNow += 1;
      }
    }
    return paymentsNow;
  }

  @override
  Widget build(BuildContext context) {
    var paymentCount = Hive.box<Payment>(HiveBoxesPayment.payment).length;
    var paymentsNow = countPayments();
    var percentage = (paymentsNow / paymentCount).toStringAsFixed(2);
    return Scaffold(
      backgroundColor: Color(0xfff3f5f9),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Text(
                        'Payment Page',
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.63,
                        child: StudentTabs()),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: ProjectStatisticsCard(
                              count: 'Payments',
                              name: 'Available Records',
                              descriptions: 'Database Analytics',
                              progress: 1.0,
                              progressString: '$paymentCount',
                              color: const Color(0xffFAAA1E),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: ProjectStatisticsCard(
                              count: 'Payments',
                              name: 'Recorded Today',
                              descriptions: 'Database Analytics',
                              progress: double.parse(percentage),
                              progressString: '$paymentsNow',
                              color: const Color(0xff6C6CE5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Text(
                        'Payment List',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 1.9,
                        margin: EdgeInsets.only(left: 25),
                        width: MediaQuery.of(context).size.width * 0.59,
                        child: const PaymentScreen(
                          title: 'title',
                        )),
                  ],
                ),
              ],
            ),
            NavibarPayment(),
            PaymentInfo(),
          ],
        ),
      ),
    );
  }
}
