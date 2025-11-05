import 'package:flutter/material.dart';

class SuppliersPage extends StatelessWidget {
  const SuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Suppliers',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.search),
                Icon(Icons.waterfall_chart_outlined)
              ],
            )
          ],
        )
      ],
    );
  }
}
