import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Settings',
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
