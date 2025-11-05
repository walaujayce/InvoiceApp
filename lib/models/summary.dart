import 'package:flutter/material.dart';
class Summary {
  final String selectedType;
  final String title;
  final int count;
  final double total;
  final LinearGradient linearGradient;

  const Summary({
    required this.selectedType,
    required this.title,
    required this.count,
    required this.total,
    required this.linearGradient
  });
}