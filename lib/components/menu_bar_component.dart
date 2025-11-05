import 'package:flutter/material.dart';

class MenuBarComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  const MenuBarComponent({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlue[200] : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 26.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0
            ),
          )
        ],
      ),
    );
  }
}
