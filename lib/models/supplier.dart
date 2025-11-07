import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Supplier {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String classification;
  final int invoiceCount;

  Supplier({
    String? id,
    required this.name,
    this.email = "",
    this.phone = "",
    this.address = "",
    this.classification = "",
    this.invoiceCount = 0,
  }) : id = id ?? Uuid().v4();
}
