import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Item {
  final String id;
  final String name;
  final double price;
  final int unit;
  final int category;
  final String description;

  Item({
    String? id,
    required this.name,
    this.price = 0.0,
    this.unit = 0,
    this.category = 0,
    this.description = "",
  }) : id = id ?? Uuid().v4();
}
