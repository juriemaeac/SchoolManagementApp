import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:smapp/api/pdf_api.dart';
import 'package:smapp/model/studentPDF.dart';
import 'package:smapp/model/invoice.dart';
import 'package:smapp/model/supplier.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/utils.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 20),
        buildSubjects(invoice.studentPDF),
        buildFooter(invoice),
        SizedBox(height: 1 * PdfPageFormat.cm),
        dashedHorizontalLine(),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildHeader(invoice),
        SizedBox(height: 20),
        buildSubjects(invoice.studentPDF),
        buildFooterStudent(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pw.Text(
            "NATIONAL POLYTECHNIC COLLEGE SCIENCE AND TECHNOLOGY",
            style: TextStyle(
              fontSize: 14.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          pw.Text(
            "Main: Blk 125, Lot 22, Quirino Highway, Lagro, Quezon City",
            style: TextStyle(
              fontSize: 10.00,
            ),
          ),
          pw.Text(
            "Annex: 892 Alfina Bldg., 2nd Floor, Gulod, Novaliches, Quezon City",
            style: TextStyle(
              fontSize: 10.00,
            ),
          ),
          SizedBox(height: 0.8 * (PdfPageFormat.cm)),
          pw.Text(
            "CERTIFICATE OF MATRICULATION",
            style: TextStyle(
              fontSize: 14.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 0.8 * (PdfPageFormat.cm)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStudentInfo(invoice.studentPDF),
                buildInvoiceInfo(invoice.info),
              ],
            ),
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

  static Widget buildStudentInfo(StudentPDF studentPDF) => Column(
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
                  style: TextStyle(fontSize: 12)),
              Text(studentPDF.name, style: TextStyle(fontSize: 12)),
              Text(studentPDF.course, style: TextStyle(fontSize: 12)),
            ]),
          ]),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Invoice Date: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text('Payment Method: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text('Account Balance: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
            pw.SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(Utils.formatDate(info.date), style: TextStyle(fontSize: 12)),
              Text(info.number, style: TextStyle(fontSize: 12)),
              Text('Php ${info.balance.toString()}',
                  style: TextStyle(fontSize: 12)),
            ]),
            // Row(children: [
          ]),
        ],
      );

  static Widget buildSubjects(StudentPDF studentPDF) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subjects Enrolled",
            style: TextStyle(
              fontSize: 12.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          pw.Divider(),
          Text(
            studentPDF.subjects,
            style: TextStyle(
              fontSize: 10.00,
            ),
          ),
          Divider(),
        ],
      );
  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'Approved by:',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            pw.SizedBox(height: 15),
            Text(
              '_____________________',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ]),
          SizedBox(height: 10),
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              invoice.info.description,
              style: TextStyle(
                fontSize: 10,
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

          //buildSimpleText(title: 'Address', value: invoice.supplier.address),
          //SizedBox(height: 30),
          //buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static Widget buildFooterStudent(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'Approved by:',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            pw.SizedBox(height: 20),
            Text(
              '_____________________',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ]),
          SizedBox(height: 10),
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              invoice.info.description,
              style: TextStyle(
                fontSize: 10,
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

          //buildSimpleText(title: 'Address', value: invoice.supplier.address),
          //SizedBox(height: 30),
          //buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
