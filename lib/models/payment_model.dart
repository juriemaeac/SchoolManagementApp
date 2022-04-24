import 'package:hive/hive.dart';
part 'payment_model.g.dart';

@HiveType(typeId: 2)
class Payment extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  late int studentID;
  @HiveField(2)
  late String facultyUsername;
  @HiveField(3)
  late String transactionDate;
  @HiveField(4)
  late double transactionAmount;
  @HiveField(5)
  late double newAccountBalance;

  Payment(
      {required this.studentID,
      required this.facultyUsername,
      required this.transactionDate,
      required this.transactionAmount,
      required this.newAccountBalance});
}
