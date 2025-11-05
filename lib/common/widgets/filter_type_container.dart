import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class FilterTypeContainer extends StatelessWidget {
  final bool isSelected;
  final double height;
  final String content;
  const FilterTypeContainer({super.key, required this.isSelected, required this.height, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: isSelected ? AppContainerColor.filterSelected : AppContainerColor.filterUnselected,
        borderRadius: BorderRadiusGeometry.circular(height / 2),
      ),
      alignment: Alignment.center,
      child: Text(
        content,
        style: TextStyle(fontSize: 13.0,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
