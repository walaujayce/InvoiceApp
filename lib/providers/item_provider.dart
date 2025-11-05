import 'package:flutter/material.dart';

import '../common/widgets/card.dart';

class ItemProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> _filterTypeList = ["ALL"];
  List<String> get filterTypeList => _filterTypeList;

  final List<ItemCard> _itemCardList = [
    ItemCard(itemName: "Item A", itemPrice: 10.00),
    ItemCard(itemName: "Item B", itemPrice: 20.00),
    ItemCard(itemName: "Item C", itemPrice: 30.00),
  ];

  String get selectedFilter => _filterTypeList[_selectedIndex];
  List<ItemCard> get filteredCardList {
    if (selectedFilter == "ALL") {
      return _itemCardList;
    } else {
      return _itemCardList.where((card) {
        return card.category == selectedFilter;
      }).toList();
    }
  }

  // --- METHODS (Logic) ---

  // This replaces onFilterTypeSelected
  void updateFilter(int index) {
    _selectedIndex = index;
    notifyListeners(); // This tells the UI to rebuild
  }

  // This replaces addInvoiceCard
  void addItemCard() {
    _itemCardList.add(ItemCard(itemName: "New Item", itemPrice: 99.00));
    notifyListeners(); // This tells the UI to rebuild
  }
}
