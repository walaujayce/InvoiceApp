import 'package:flutter/material.dart';

class EstimatesPage extends StatelessWidget {
  const EstimatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Estimates',
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
