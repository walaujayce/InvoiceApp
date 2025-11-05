import 'package:flutter/material.dart';

class SummaryComponent extends StatelessWidget {

  final String selectedType;
  final String title;
  final int count;
  final double total;
  final LinearGradient linearGradient;

  const SummaryComponent({
    super.key,
    required this.selectedType,
    required this.title,
    required this.count,
    required this.total,
    required this.linearGradient
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.circular(12)
      ),
      height: 100.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Text(
            "$count $selectedType",
          ),
          Text(
            "RM$total",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

