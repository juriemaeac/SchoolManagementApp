import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:smapp/models/payment_model.dart';
import 'package:smapp/pdf_payment/api_payment/pdf_api_payment.dart';
import 'package:smapp/pdf_payment/model_payment/invoice_payment.dart';
import 'package:smapp/pdf_payment/model_payment/studentPDF_payment.dart';
import 'package:smapp/pdf_payment/utils_payment.dart';

class PdfInvoiceApiPayment {
  static Future<File> generate(InvoicePayment invoice) async {
    final pdf = Document();
    final imageSvg = await rootBundle.loadString('assets/logo.svg');

    pdf.addPage(MultiPage(
      build: (context) => [
        pw.Column(children: [
          pw.Row(children: [
            SvgImage(svg: imageSvg, width: 50, height: 50),
            pw.SizedBox(width: 10),
            buildHeader(invoice),
          ]),
        ]),
        buildInfoSection(invoice),
        SizedBox(height: 10),
        buildFooter(invoice),
        SizedBox(height: 1 * PdfPageFormat.cm),
        dashedHorizontalLine(),
        SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Column(children: [
          pw.Row(children: [
            SvgImage(svg: imageSvg, width: 50, height: 50),
            pw.SizedBox(width: 10),
            buildHeader(invoice),
          ]),
        ]),
        buildInfoSection(invoice),
        SizedBox(height: 10),
        buildFooterStudent(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return PdfApiPayment.saveDocument(name: 'Payment_Receipt.pdf', pdf: pdf);
  }

  static Widget buildHeader(InvoicePayment invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pw.Text(
            "NATIONAL POLYTECHNIC COLLEGE SCIENCE AND TECHNOLOGY",
            style: TextStyle(
              fontSize: 12.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          pw.Text(
            "Main: Blk 125, Lot 22, Quirino Highway, Lagro, Quezon City",
            style: const TextStyle(
              fontSize: 10.00,
            ),
          ),
        ],
      );

  static Widget buildInfoSection(InvoicePayment invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.3 * (PdfPageFormat.cm)),
          pw.Text(
            "PAYMENT RECEIPT",
            style: TextStyle(
              fontSize: 14.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 0.5 * (PdfPageFormat.cm)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStudentInfo(invoice.studentPDFPayment),
                buildInvoiceInfo(invoice.info, invoice.studentPDFPayment),
              ],
            ),
          ]),
          pw.SizedBox(height: 15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            pw.SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              pw.Expanded(
                  child: pw.Container(
                width: PdfPageFormat.cm / 2.2,
                //color: PdfColors.grey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // buildTuitionInfo(invoice.studentPDFPayment),
                      // pw.SizedBox(height: 10),
                      Text('Transaction Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      pw.Divider(),
                      buildTransacInfo(invoice.payment),
                      Divider(),
                    ]),
              )),
              //pw.SizedBox(width: 115),
              pw.Expanded(
                  child: pw.Container(
                //color: PdfColors.amber,
                padding: const pw.EdgeInsets.only(left: 60),
                width: PdfPageFormat.cm / 2.2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Monthly Tuition Breakdown: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Divider(),
                      buildTuitionBreakdownInfo(invoice.studentPDFPayment),
                      Divider(),
                    ]),
              )),
            ]),
          ]),
        ],
      );

  static Widget dashedHorizontalLine() {
    return Row(
      children: [
        for (int i = 0; i < 20; i++)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static Widget buildStudentInfo(StudentPDFPayment studentPDF) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Student Number: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text('Student Name: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text('Course YearSection: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
            pw.SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(studentPDF.studentId.toString(),
                  style: const TextStyle(fontSize: 12)),
              Text(studentPDF.name, style: const TextStyle(fontSize: 12)),
              Text(studentPDF.course, style: const TextStyle(fontSize: 12)),
            ]),
          ]),
        ],
      );

  static Widget buildTuitionBreakdownInfo(StudentPDFPayment studentPDF) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(studentPDF.paymentBreakdown.toString(),
                  style: const TextStyle(fontSize: 12)),
            ]),
            pw.SizedBox(width: 15),
          ]),
        ],
      );

  static Widget buildTransacInfo(Payment payment) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const pw.EdgeInsets.all(0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //BINAYARAN
              Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Date: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Text('Amount: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  pw.SizedBox(height: 10),
                ]),
                pw.SizedBox(width: 80),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(payment.transactionDate,
                      style: const TextStyle(fontSize: 12)),
                  Text('Php ${payment.transactionAmount.toString()}',
                      style: const TextStyle(fontSize: 12)),
                  pw.SizedBox(height: 10),
                ]),
              ]),

              //NEW BALNCE
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('New Balance: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ]),
                pw.SizedBox(width: 50),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Php ${payment.newAccountBalance.toString()}',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.red)),
                ]),
              ]),
            ]),
          ),

          //Divider(),
        ],
      );

  static Widget buildInvoiceInfo(
          InvoiceInfoPayment info, StudentPDFPayment studentPDF) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Invoice Date: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text('Payment Method: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text('Total Tuition Fee: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
            pw.SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(UtilsPayment.formatDate(info.date),
                  style: const TextStyle(fontSize: 12)),
              Text(info.method, style: const TextStyle(fontSize: 12)),
              Text('Php ${studentPDF.courseFee.toString()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: PdfColors.red,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
          ]),
        ],
      );
  static Widget buildFooter(InvoicePayment invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              invoice.info.description,
              textAlign: pw.TextAlign.justify,
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.red,
              ),
            ),
            pw.SizedBox(height: 10),
            Text(
              "[ ACCOUNTING DEPARTMENT'S COPY ]",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ],
      );

  static Widget buildFooterStudent(InvoicePayment invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              invoice.info.description,
              textAlign: pw.TextAlign.justify,
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.red,
              ),
            ),
            pw.SizedBox(height: 10),
            Text(
              "[ STUDENT'S COPY ]",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ],
      );
}
