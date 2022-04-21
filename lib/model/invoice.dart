import 'package:smapp/model/studentPDF.dart';
import 'package:smapp/model/supplier.dart';
import 'package:smapp/models/faculty_model.dart';

class Invoice {
  final InvoiceInfo info;
  // final Supplier supplier;
  // final Faculty faculty;
  final StudentPDF studentPDF;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    // required this.supplier,
    // required this.faculty,
    required this.studentPDF,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number; //itooooooooooooooooooooooo
  final DateTime date;
  final double balance;
  //final int paymentMethod;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.balance,
    //required this.paymentMethod,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
