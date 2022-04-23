import 'package:smapp/pdf/model/studentPDF.dart';

class Invoice {
  final InvoiceInfo info;
  final StudentPDF studentPDF;

  const Invoice({
    required this.info,
    required this.studentPDF,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final double balance;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.balance,
  });
}

