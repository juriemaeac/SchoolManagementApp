import 'package:smapp/models/payment_model.dart';
import 'package:smapp/pdf_payment/model_payment/studentPDF_payment.dart';

class InvoicePayment {
  final InvoiceInfoPayment info;
  final StudentPDFPayment studentPDFPayment;
  final Payment payment;

  const InvoicePayment({
    required this.info,
    required this.studentPDFPayment,
    required this.payment,
  });
}

class InvoiceInfoPayment {
  final String description;
  final String method;
  final DateTime date;
  final String facultyName;

  const InvoiceInfoPayment({
    required this.description,
    required this.method,
    required this.date,
    required this.facultyName,
  });
}
