import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String title;
  final List<DropdownMenuEntry<dynamic>> dropDownList;
  final dynamic initialSelection; // To set the starting value
  final void Function(dynamic)? onSelected; // To get the new value
  const CustomDropdownMenu({
    super.key,
    required this.title,
    required this.dropDownList,
    this.initialSelection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 50,
      child: DropdownMenu(
        width: double.infinity,
        inputDecorationTheme: InputDecorationTheme(
          // Border when the dropdown is enabled but not focused
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDDDCDC), width: 1.0),
          ),
          // Border when the dropdown is focused (active)
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          // Border by default (optional, often overridden by enabled/focused)
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDDDCDC)),
          ),
        ),
        dropdownMenuEntries: dropDownList,
        initialSelection: initialSelection,
        onSelected: onSelected,
        label: Text(title, style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
