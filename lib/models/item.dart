import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Item {
  final String id;
  final String name;
  final double price;
  final String unit;
  final String category;
  final String description;

  Item({
    String? id,
    required this.name,
    this.price = 0.0,
    this.unit = "",
    this.category = "",
    this.description = "",
  }) : id = id ?? Uuid().v4();
}
