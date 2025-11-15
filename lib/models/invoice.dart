import 'package:uuid/uuid.dart';
import '../util/enums.dart';

var uuid = Uuid();

class Invoice {
  final String id;
  final EPaymentState paymentStatus;
  final String setDate;
  final String clientName;
  final String invoiceID;
  final String paymentStatusString;
  final double invoiceTotal;
  final String remark1;
  final String remark2;

  Invoice({
    String? id,
    required this.paymentStatus,
    required this.setDate,
    required this.clientName,
    required this.invoiceID,
    required this.paymentStatusString,
    required this.invoiceTotal,
    this.remark1 = "",
    this.remark2 = "",
  }) : id = id ?? Uuid().v4();
}
