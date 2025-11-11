import 'package:flutter/foundation.dart';
import '../common/widgets/card.dart';
import '../models/item.dart';

class ItemProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> _filterTypeList = ["ALL"];
  List<String> get filterTypeList => _filterTypeList;

  final List<ItemCard> _itemCardList = [
    ItemCard(item: Item(name: "Item A", price: 10.00)),
    ItemCard(item: Item(name: "Item B", price: 20.00)),
    ItemCard(item: Item(name: "Item C", price: 30.00)),
  ];

  String get selectedFilter => _filterTypeList[_selectedIndex];
  List<ItemCard> get filteredCardList {
    if (selectedFilter == "ALL") {
      return _itemCardList;
    } else {
      return _itemCardList.where((card) {
        return card.item.category == selectedFilter;
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
  void addItemCard(Item newItem) {
    _itemCardList.add(ItemCard(item: newItem));
    notifyListeners(); // This tells the UI to rebuild
  }

  void updateItemCard(Item updatedItem) {
    // Find the index of the card that needs to be updated.
    if(kDebugMode){
      print("updatedItem:");
      print("id: ${updatedItem.id}");
      print("name: ${updatedItem.name}");
    }
    final int index = _itemCardList.indexWhere(
          (card) => card.item.id == updatedItem.id,
    );
    // If found, update it
    if (index != -1) {
      _itemCardList[index] = ItemCard(item: updatedItem);
      notifyListeners();
    }
  }

  void deleteItemCard(String itemId) {
    // Remove the card where the supplier ID matches.
    _itemCardList.removeWhere((card) => card.item.id == itemId);
    notifyListeners(); // Tell the UI to rebuild
  }
}
