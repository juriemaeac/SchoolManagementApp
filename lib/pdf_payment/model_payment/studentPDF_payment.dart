class StudentPDFPayment {
  final int studentId;
  final String name;
  final String course;
  final String subjects;
  final double courseFee;
  final int paymentMode;
  final double paymentBalance;
  final String paymentBreakdown;

  const StudentPDFPayment({
    required this.studentId,
    required this.name,
    required this.course,
    required this.subjects,
    required this.courseFee,
    required this.paymentMode,
    required this.paymentBalance,
    required this.paymentBreakdown,
  });
}
