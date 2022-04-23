import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/payment_transaction_page.dart';

import '../../boxes/boxPayment.dart';
import '../../models/payment_model.dart';



class MeetingsSection extends StatefulWidget {
  const MeetingsSection({ Key? key }) : super(key: key);

  @override
  State<MeetingsSection> createState() => _MeetingsSectionState();
}

class _MeetingsSectionState extends State<MeetingsSection> {
    @override
    Widget build(BuildContext context) {
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
    var boxValues = Hive.box<Payment>(HiveBoxesPayment.payment);

    return Column(
      children: [
        const SizedBox(height: 20),
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
                      builder: (context) => const PaymentPage(),
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
            shrinkWrap: true,
            reverse: true,
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
                          const Icon(Icons.paid, color: Colors.orange, size: 30),
                          const SizedBox(width: 10),
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
                                "${res.transactionDate.toString()}",
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
   
  }
}

