import 'package:flutter/material.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Clients',
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
