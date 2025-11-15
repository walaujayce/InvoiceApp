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
    if (selectedFilter == _filterTypeList[0]) {
      return _itemCardList;
    } else {
      return _itemCardList.where((card) {
        return card.item.category == _selectedIndex;
      }).toList();
    }
  }
  
  final Map<int, String> _unitList = {
    0: "No unit",
    1: "hrs",
    2: "kgs",
    3: "pcs",
  };
  Map<int, String> get unitList => _unitList;

  final Map<int, String> _categoryList = {
    0: "Goods",
    1: "Services",
    2: "Popular",
    3: "Merchandise",
  };
  Map<int, String> get categoryList => _categoryList;
  
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
    // Remove the card where the Item ID matches.
    _itemCardList.removeWhere((card) => card.item.id == itemId);
    notifyListeners(); // Tell the UI to rebuild
  }

  void duplicateItemCard(Item currentItem) {
    Item newItem = Item(
      name: currentItem.name,
      price: currentItem.price,
      unit: currentItem.unit,
      category: currentItem.category,
      description: currentItem.description,
    );
    _itemCardList.add(ItemCard(item: newItem));
    notifyListeners(); // This tells the UI to rebuild
  }
}
