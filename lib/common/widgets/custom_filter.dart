import 'package:flutter/material.dart';
import 'package:invoice_app/styles/colors.dart';

class CustomFilterIcon extends StatelessWidget {
  final double height;

  const CustomFilterIcon({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height + 10,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppContainerColor.filterUnselected,
        ),
        child: Icon(Icons.filter_alt_sharp ,color: Colors.pink[300],),
      ),
    );
  }
}
