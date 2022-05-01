import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:smapp/pdf/api/pdf_api.dart';
import 'package:smapp/pdf/model/invoice.dart';
import 'package:smapp/pdf/model/studentPDF.dart';
import 'package:smapp/pdf/utils.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final imageSvg = await rootBundle.loadString('assets/logo.svg');
    

    pdf.addPage(MultiPage(
      build: (context) => [
        pw.Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          pw.Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgImage(svg: imageSvg, width: 40, height: 40),
            pw.SizedBox(width: 10),
            buildHeader(invoice),
            pw.SizedBox(width: 40),
          ]),
        ]),
        buildInfoSection(invoice),
        SizedBox(height: 10),
        buildSubjects(invoice.studentPDF),
        SizedBox(height: 10),
        buildFooter(invoice),
        SizedBox(height: 10),
        dashedHorizontalLine(),
        SizedBox(height: 10),
        pw.Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          pw.Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgImage(svg: imageSvg, width: 40, height: 40),
            pw.SizedBox(width: 10),
            buildHeader(invoice),
            pw.SizedBox(width: 40),
          ]),
        ]
        ),
        buildInfoSection(invoice),
        SizedBox(height: 10),
        buildSubjects(invoice.studentPDF),
        SizedBox(height: 10),
        buildFooterStudent(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    pdf.addPage(MultiPage(
      build: (context) => [
        pw.Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          pw.Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgImage(svg: imageSvg, width: 40, height: 40),
            pw.SizedBox(width: 10),
            buildHeader(invoice),
            pw.SizedBox(width: 40),
          ]),
        ]),
        buildInfoSection(invoice),
        SizedBox(height: 10),
        buildSubjects(invoice.studentPDF),
        SizedBox(height: 10),
        buildFooter(invoice),
        SizedBox(height: 10),
        dashedHorizontalLine(),
        SizedBox(height: 10),
        pw.Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          pw.Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgImage(svg: imageSvg, width: 40, height: 40),
            pw.SizedBox(width: 10),
            buildHeader(invoice),
            pw.SizedBox(width: 40),
          ]),
        ]
        ),
        buildInfoSection(invoice),
        SizedBox(height: 10),
        buildSubjects(invoice.studentPDF),
        SizedBox(height: 10),
        buildFooterStudent(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'Matriculation_Certificate.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pw.Text(
            "NATIONAL POLYTECHNIC COLLEGE SCIENCE AND TECHNOLOGY",
            style: TextStyle(
              fontSize: 10.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          pw.Text(
            "Main: Blk 125, Lot 22, Quirino Highway, Lagro, Quezon City",
            style: const TextStyle(
              fontSize: 8.00,
            ),
          ),
        ],
      );

  static Widget buildInfoSection(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.1 * (PdfPageFormat.cm)),
          pw.Text(
            "CERTIFICATE OF MATRICULATION",
            style: TextStyle(
              fontSize: 10.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 0.3 * (PdfPageFormat.cm)),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              Text('Student Name: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              Text('Course Year: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            ]),
            pw.SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(studentPDF.studentId.toString(),
                  style: const TextStyle(fontSize: 10)),
              Text(studentPDF.name, style: const TextStyle(fontSize: 10)),
              Text(studentPDF.course, style: const TextStyle(fontSize: 10)),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              Text('Payment Method: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              Text('Account Balance: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            ]),
            pw.SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(Utils.formatDate(info.date),
                  style: const TextStyle(fontSize: 10)),
              Text(info.number, style: const TextStyle(fontSize: 10)),
              Text('Php ${info.balance.toString()}',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.red)),
            ]),
            // Row(children: [
          ]),
        ],
      );

  static Widget buildSubjects(StudentPDF studentPDF) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pw.Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 100),
              Column(
                children:[
                  Text("Subject Code",
                    style: TextStyle(
                      fontSize: 10.00,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ),
              SizedBox(width: 90),
              Column(
                children:[
                  Text(
                    "Units",
                    style: TextStyle(
                      fontSize: 10.00,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 100),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 100),
              Column(
                children:[
                  Text(
                studentPDF.subjects,
                style: const TextStyle(
                  fontSize: 10.00,
                ),
              ),

                ]
              ),
              SizedBox(width: 90),
              Column(
                children:[
                  Text(
                    studentPDF.subjectUnits,
                    style: const TextStyle(
                      fontSize: 10.00,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 100),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Text(
                "Total Units: ",
                style: TextStyle(
                  fontSize: 10.00,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Text(
                studentPDF.totalUnits.toString(),
                style: const TextStyle(
                  fontSize: 10.00,
                ),
              ),
            ],
          ),

        ],
      );
  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'Approved by:',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            pw.SizedBox(height: 10),
            Text(
              '_____________________',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
          ]),
          SizedBox(height: 15),
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              invoice.info.description,
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.red,
              ),
            ),
            pw.SizedBox(height: 10),
            Text(
              "[ ACCOUNTING DEPARTMENT'S COPY ]",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ],
      );

  static Widget buildFooterStudent(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'Approved by:',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            pw.SizedBox(height: 15),
            Text(
              '_____________________',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
          ]),
          SizedBox(height: 10),
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              invoice.info.description,
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.red,
              ),
            ),
            pw.SizedBox(height: 10),
            Text(
              "[ STUDENT'S COPY ]",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ],
      );
}
