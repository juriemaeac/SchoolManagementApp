import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/Dashboard/src/SubHeader.dart';
import 'package:smapp/screens/payment_transaction_screen.dart';

import '../../boxes/boxPayment.dart';
import '../../models/payment_model.dart';

class MeetingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
    var boxValues = Hive.box<Payment>(HiveBoxesPayment.payment);

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Recent Transactions',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              InkWell(
                child: Text(
                  'View All',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.black45,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(
                        title: 'title',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height - 300,
          width: MediaQuery.of(context).size.width / 4.3,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount:
                boxValues.values.length < 20 ? boxValues.values.length : 20,
            itemBuilder: (context, index) {
              Payment? res = boxValues.getAt(index);
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7.5,
                      spreadRadius: 1.0,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 10.0,
                    runSpacing: 20.0,
                    direction: Axis.vertical,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.paid),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Student: ${res!.studentID.toString()} : Paid ${res.transactionAmount.toString()}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Cashier: ${res.facultyUsername.toString()} @ ${res.transactionDate.toString()}",
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              );
            },
          ),
        ),
      ],
    );
    //return Container(
    // child: Column(
    //   children: [
    //     SubHeader(
    //       title: 'Recent Transactions',
    //     ),
    //     //paglalagyan
    //     Container(
    //       height: 100.0,
    //       width: double.infinity,
    //       margin: EdgeInsets.symmetric(horizontal: 30.0),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //       child: Row(
    //         children: [
    //           Container(
    //             width: 10.0,
    //             decoration: BoxDecoration(
    //               color: Colors.red.withOpacity(0.8),
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(10.0),
    //                 bottomLeft: Radius.circular(10.0),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: MediaQuery.of(context).size.width * 0.27 - 60.0,
    //             padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       'Projects Overview',
    //                       style: GoogleFonts.quicksand(
    //                         fontSize: 13.0,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Icon(
    //                       Icons.more_horiz,
    //                       size: 20.0,
    //                       color: Colors.black26,
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(width: 5.0),
    //                 Text(
    //                   '09 AM - 10 AM',
    //                   style: GoogleFonts.quicksand(
    //                     fontSize: 9.0,
    //                   ),
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.only(top: 13.0),
    //                   height: 50.0,
    //                   child: Stack(
    //                     children: [
    //                       Positioned(
    //                         left: 0.0,
    //                         child: Container(
    //                           height: 30.0,
    //                           width: 30.0,
    //                           decoration: BoxDecoration(
    //                             color: Colors.red,
    //                             borderRadius: BorderRadius.circular(20.0),
    //                             border: Border.all(
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         left: 20.0,
    //                         child: Container(
    //                           height: 30.0,
    //                           width: 30.0,
    //                           decoration: BoxDecoration(
    //                             color: Colors.red,
    //                             borderRadius: BorderRadius.circular(20.0),
    //                             border: Border.all(
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         left: 40.0,
    //                         child: Container(
    //                           height: 30.0,
    //                           width: 30.0,
    //                           decoration: BoxDecoration(
    //                             color: Colors.grey[800],
    //                             borderRadius: BorderRadius.circular(20.0),
    //                             border: Border.all(
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                           child: Icon(
    //                             Icons.add,
    //                             size: 15.0,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // ),
    //);
  }
}
