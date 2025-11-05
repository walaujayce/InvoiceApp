import 'package:flutter/material.dart';
import 'package:invoice_app/components/menu_bar_component.dart';

class MenuBar extends StatelessWidget {

  final void Function(int) onMenuItemSelected;
  final int selectedIndex;

  MenuBar({
    super.key,
    required this.onMenuItemSelected,
    required this.selectedIndex,
  });

  final List<String> _menuBarItems = [
    "Invoices",
    "Estimates",
    "Items",
    "Clients",
    "Suppliers",
    "Settings"
  ];

  final List<IconData> _menuBarIcons = [
    Icons.description_outlined,
    Icons.calculate_outlined,
    Icons.shopping_cart_outlined,
    Icons.account_circle_outlined,
    Icons.factory_outlined,
    Icons.settings_applications_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[400],
      width: 100.0,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        itemBuilder: (BuildContext context, int index) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onMenuItemSelected(index),
            child: MenuBarComponent(
              icon: _menuBarIcons[index],
              title: _menuBarItems[index],
              isSelected: isSelected,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 0.0);
        },
        itemCount: _menuBarItems.length,
      ),
    );
  }
}
