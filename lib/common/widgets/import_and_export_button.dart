import 'package:flutter/material.dart';
import 'package:invoice_app/styles/colors.dart';

class ImportAndExportButton extends StatelessWidget {
  const ImportAndExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
      child: Text(
        "Import / Export",
        style: TextStyle(
          color: AppColor.blue,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
